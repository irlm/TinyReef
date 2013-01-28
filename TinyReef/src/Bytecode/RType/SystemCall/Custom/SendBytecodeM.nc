/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Set 08, 2009.
 *
 */
 
#include "TinyReefMessage.h"
#include "TinyReefProcessState.h"

//timeout 1 second
#define SEND_TIMEOUT	1000

module SendBytecodeM
{
	provides
	{
		interface TinyReefBytecode;
	}
	uses
	{
		interface Resource;
		interface TinyReefInterpreter;
		
		interface TinyReefSend;
		
		interface Timer<TMilli> as Timeout;
	}	
}

implementation
{
	uint8_t state;
	tinyReefContext_t* tinyReefContext;	

	command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
   		/*
    	 * 
    	 * Register
    	 * a0 -> DestinationAddress
    	 * a1 -> am_id_t
    	 * a2 -> dataMemoryAddress
    	 * a3 -> dataLength (1 -> 1 byte from memory)
    	 * 
		*/ 	
    	error_t ret = FAIL;
    	   
    	uint16_t DestinationAddress;
    	am_id_t id;
		uint32_t dataMemoryAddress;
    	uint8_t dataLength;
    	
    	tinyReefPacketHead_t tinyReefPacketHead;
    	
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - SendBytecodeM\n");
		
		//16 bits
    	DestinationAddress = 0xFFFF & (context->registerFile[R_A0]);
    	dbg("TinyReefBytecode", "SendBytecodeM - DestinationAddress = 0x%4X \n", DestinationAddress);
    	
		id = (am_id_t)(0xFF & (context->registerFile[R_A1]));
		dbg("TinyReefBytecode", "SendBytecodeM - id = %d\n", id);
		
		dataMemoryAddress = context->registerFile[R_A2];
		dbg("TinyReefBytecode", "SendBytecodeM - dataMemoryAddress = 0x%8X\n", dataMemoryAddress);
		dataLength = (uint8_t)(0xFF & (context->registerFile[R_A3]));
		dbg("TinyReefBytecode", "SendBytecodeM - dataLength = %d\n", dataLength);
		
		tinyReefPacketHead.version = 0;
		tinyReefPacketHead.packet_number = 1;
		tinyReefPacketHead.total_packet = 1;
		tinyReefPacketHead.length = dataLength;
		
		dbg("TinyReefBytecode", "SendBytecodeM - tinyReefPacketHead.version = %d\n", tinyReefPacketHead.version);
		dbg("TinyReefBytecode", "SendBytecodeM - tinyReefPacketHead.packet_number = %d\n", tinyReefPacketHead.packet_number);
		dbg("TinyReefBytecode", "SendBytecodeM - ttinyReefPacketHead.total_packet = %d\n", tinyReefPacketHead.total_packet);
		dbg("TinyReefBytecode", "SendBytecodeM - tinyReefPacketHead.length = %d\n", tinyReefPacketHead.length);
		
		ret = call TinyReefSend.SendPacket(id, DestinationAddress,
		 			&tinyReefPacketHead,
		 			&context->Memory[(dataMemoryAddress - context->Offset) & 0xFFFF], dataLength);
		
		if(SUCCESS == ret)
		{
			dbg("TinyReefBytecode", "SendBytecodeM - Blocking...\n");
		
			state = context->state;
			context->state = BLOCKED;
			tinyReefContext = context;
			
			call Timeout.startOneShot(SEND_TIMEOUT);	
		}
		
		return ret;           	
     }	
  

	event void Resource.granted()
	{
		dbg("TinyReefBytecode", "SendBytecodeM - Resource.granted()\n");
		
		tinyReefContext->state = state;
		
		call TinyReefInterpreter.interpreterProgram(tinyReefContext);
		
		call Resource.release();
	}

	event void TinyReefInterpreter.interpreterProgramDone(error_t error)
	{
		dbg("TinyReefBytecode", "SendBytecodeM - TinyReefInterpreter.interpreterProgramDone\n");
	}

	event void TinyReefSend.SendPacketDone(error_t error)
	{
		dbg("TinyReefBytecode", "SendBytecodeM - TinyReefSend.SendPacketDone\n");

		call Resource.request();
	}

	event void Timeout.fired()
	{
		dbg("TinyReefBytecode", "SendBytecodeM - TIMEOUT\n");
		//timeout...
		tinyReefContext->state = state;
		//but don't return to the next instruction....
		call Resource.release();
	}
}