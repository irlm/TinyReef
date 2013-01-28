/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/**
 * @author Igor L Marques
 * @date:   Mar 22, 2010.
 *
 */

#include "TinyReefSense.h"
#include "TinyReefProcessState.h"

//timeout 2 seconds
#define SENSE_TIMEOUT 2000

module SenseBytecodeM
{
	provides
	{
		interface TinyReefBytecode;	
	}
	
	uses
	{
		interface Resource;
		interface TinyReefInterpreter;
		
		interface Read<uint16_t>[uint8_t type];
		
		interface TinyReefMemoryAccess as Memory;
		
		interface Timer<TMilli> as Timeout;
	}
}

implementation
{
	
	uint8_t current_id = 0xFF;
	
	uint8_t state;
	tinyReefContext_t* tinyReefContext;

	senseTableEntry_t senseTableEntry[NUMBER_OF_SENSE_TYPES_SUPPORTED];
	
	command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
	{
		/*
    	 * 
    	 * Register
    	 * a0 -> Sense Type
    	 * a1 -> dataMemoryAddress
    	 * a2 -> dataLength (1 -> 1 byte from memory)
    	 * 
		*/ 	
    	error_t ret = FAIL;
    	
    	uint8_t	senseType;
		uint32_t dataMemoryAddress;
    	uint8_t dataLength;
		
		
		dbg("TinyReefSense", "TinyReefBytecode.execute - SenseBytecodeM\n");
    	
    	senseType = (uint8_t)(0xFF & (context->registerFile[R_A0]));
    	dbg("TinyReefSense", "SenseBytecodeM - senseType = %d \n", senseType);
    	
    	dataMemoryAddress = 0xFFFF & (context->registerFile[R_A1]);
    	dbg("TinyReefSense", "SenseBytecodeM - dataMemoryAddress = %d \n", dataMemoryAddress);
    	
    	dataLength = (uint8_t)(0xFF & (context->registerFile[R_A2]));
		dbg("TinyReefSense", "SenseBytecodeM - dataLength = %d\n", dataLength);
	
		tinyReefContext = context;
			
		if(senseType < NUMBER_OF_SENSE_TYPES_SUPPORTED)
		{
			dbg("TinyReefSense", "call Read.read[%d]()\n", senseType);
			
			senseTableEntry[senseType].dataMemoryAddress = dataMemoryAddress;
			senseTableEntry[senseType].dataLength = dataLength;
			
			dbg("TinyReefSense", "SenseBytecodeM - Blocking...\n");
		
			state = context->state;
			context->state = BLOCKED;
			
			current_id = senseType;
			
			ret = call Read.read[senseType]();
		}
		else
		{
			dbg("TinyReefSense", "senseType = %d not supported\n", senseType);
		}
		
		return ret;
		
	}
	
	event void Resource.granted()
	{
		dbg("TinyReefBytecode", "SenseBytecodeM - Resource.granted()\n");
		
		tinyReefContext->state = state;
		
		call TinyReefInterpreter.interpreterProgram(tinyReefContext);
		
		call Resource.release();
	}

	event void TinyReefInterpreter.interpreterProgramDone(error_t error)
	{
		dbg("TinyReefBytecode", "SenseBytecodeM - TinyReefInterpreter.interpreterProgramDone\n");
	}

	event void Read.readDone[uint8_t type](error_t result, uint16_t val)
	{
		if(SUCCESS == result && (tinyReefContext != NULL))
		{
			if(type == current_id)
			{
				uint32_t addr = (senseTableEntry[type].dataMemoryAddress - tinyReefContext->Offset) & 0xFFFF;
				dbg("TinyReefSense", "SenseBytecodeM -Read.readDone[%d] = 0x%4X\n", type, val);
					
				if(NULL != memcpy(&tinyReefContext->Memory[addr], &val, senseTableEntry[type].dataLength))
				{
					dbg("TinyReefSense", "SenseBytecodeM -> readDone DONE.\n");
				}
				else
				{
					dbg("TinyReefSense", "SenseBytecodeM - memcpy from data -> FAIL\n");
				}
				
				call Resource.request();
			}
		}
		else
		{
			dbg("TinyReefSense", "Read.readDone - FAIL\n");
		}
		
	}
	
	
	event void Timeout.fired()
	{
		dbg("TinyReefBytecode", "SendBytecodeM - TIMEOUT\n");
		//timeout...
		tinyReefContext->state = state;
		//but don't return to the next instruction....
		call Resource.release();
	}
	
	default command error_t Read.read[uint8_t type]()
	{
		dbg("TinyReefC", "Sense type:%d invalid or not supported.\n", type);
		
		tinyReefContext->state = state;
		
		call Resource.release();			
		
		return 	FAIL;
	}
	
}