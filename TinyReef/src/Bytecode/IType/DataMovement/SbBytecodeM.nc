/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   May 04, 2010.
 *
 */

#include "TinyReef.h"

/**
 * 
 * The 16-bit offset is sign extended and added to Reg.File[Rs] to form an effective address.
 * The least significant 8-bit byte in Reg.File[Rt] are stored in memory at the effective
 * address.
 * 
 * @author Igor L Marques
 * 
 */ 
module SbBytecodeM
{
	provides
	{
		 interface TinyReefBytecode;
	}
	uses
	{
		interface TinyReefMemoryAccess as Memory;
	}
}

implementation
{
    command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	5 bits	5 bits	16 bits
    	 * 100000	Rs		Rt 		offset
    	 * 
    	 * sample:
    	 * 100000	sssss	ttttt	iiiiiiiiiiiiiiii
		*/   
   
   		uint8_t	registerRS;
		uint8_t	registerRT;
		int16_t offset;
		
		uint32_t memAddr = 0x0;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - SbBytecodeM\n");
    	
    	//5 bits
    	registerRS = (uint8_t)(0x1F & (instruction >> 21));
    	dbg("TinyReefBytecode", "registerRS = %d \n", registerRS);
    	
    	//5 bits
    	registerRT = (uint8_t)(0x1F & (instruction >> 16));
    	dbg("TinyReefBytecode", "registerRT = %d \n", registerRT);
    	
    	//16 bits
    	offset = (int16_t)(0xFFFF & instruction);
    	dbg("TinyReefBytecode", "offset = %d \n", offset);
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRS] = 0x%8X \n", context->registerFile[registerRS]); 
    	memAddr = (context->registerFile[registerRS] + offset);    	
    	dbg("TinyReefBytecode", "memAddr = 0x%8X \n", memAddr); 
    	
    	call Memory.setByte(context, memAddr, (uint8_t) ( 0xFF & context->registerFile[registerRT]));
    	
    	//context->Memory[(context->registerFile[registerRS] + offset) & 0xFFFF] = (uint8_t) ( 0xFF & context->registerFile[registerRT]);
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRT] = %d \n", context->registerFile[registerRT]);
    
    	return SUCCESS;
    }
   
}