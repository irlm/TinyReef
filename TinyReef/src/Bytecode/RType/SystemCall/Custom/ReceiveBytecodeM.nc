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

#include "TinyReef.h"
#include "TinyReefMessage.h"

#include "AM.h"
#include "Serial.h"

module ReceiveBytecodeM
{
	provides
	{
		interface TinyReefBytecode;
		
		command void ReceivedData(uint8_t *const data, uint8_t dataLength);
	} 
	uses
	{
		interface TinyReefEventHandler as EventHandler;
    }
}

implementation
{
	uint8_t	id;
	tinyReefContext_t * tinyReefContext;

	uint32_t memoryAddressDestiny;
	uint8_t	dataLengthDestiny;

	command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	error_t ret = FAIL;
    	
    	uint32_t memoryAddress = 0x0;
    	uint32_t endEventAddress = 0x0;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - ReceiveBytecodeM\n");
    	
    	memoryAddressDestiny = context->registerFile[R_A0];
    	dbg("TinyReefBytecode", "memoryAddressDestiny = 0x%8X \n", memoryAddressDestiny);
    	
    	dataLengthDestiny = (uint8_t)(0xF & (context->registerFile[R_A1]));
    	dbg("TinyReefBytecode", "dataLengthDestiny = %d \n", dataLengthDestiny);
    	
    	memoryAddress = context->registerFile[R_A2];
    	dbg("TinyReefBytecode", "MemoryAddress = 0x%8X \n", memoryAddress);
    	
    	endEventAddress = context->registerFile[R_A3];
    	dbg("TinyReefBytecode", "MemoryAddress = 0x%8X \n", endEventAddress);
    	
    	if(context != NULL)
		{
			tinyReefContext = context;
			
			// register the handler 
			ret = call EventHandler.registerEvent(context, memoryAddress, endEventAddress, &id);
			// start the receiver
			dbg("TinyReefBytecode", "start the receiver[%d].\n", id);
		}
		   	
		return ret;
	}
	
	command void ReceivedData(uint8_t *const data, uint8_t dataLength)
	{
		dbg("TinyReefBytecode", "ReceiveBytecodeM -> ReceiveData.\n");

		dbg("TinyReefBytecode", "ReceiveBytecodeM -> memoryAddressDestiny = 0x%8X.\n", memoryAddressDestiny);
		
		if(dataLength == dataLengthDestiny)
		{
			if(NULL != memcpy(&tinyReefContext->Memory[(memoryAddressDestiny - tinyReefContext->Offset) & 0xFFFF], data, dataLength))
			{
				dbg("TinyReefBytecode", "ReceiveBytecodeM -> ReceiveData DONE.\n");
				dbg("TinyReefBytecode", "ReceiveBytecodeM -> EventHandler.executeEvent(%d).\n", id);
				call EventHandler.executeEvent(id);
			}
			else
			{
				dbg("TinyReefCommunication", "ReceiveBytecodeM - memcpy from data -> FAIL\n");
			}	
		}
		else
		{
			dbg("TinyReefCommunication", "ReceiveBytecodeM - aataLength != dataLengthDestiny -> FAIL\n");	
		}		
	}
}