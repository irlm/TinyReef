/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   May 03, 2010.
 *
 */

#include "TinyReef.h"
#include "TinyReefMemory.h"

/**
 * 
 * The 16-bit offset is sign extended and added to Reg.File[Rs] to form an effective address.
 * A 32-bit word is read from memory at the effective address and loaded into Reg.File[Rt].
 * If the least two significant bits of the effective address are not zero, an address error
 * exception occurs. There are four bytes in a word, so word addresses must be binary
 * numbers that are a multiple of four, otherwise an address error exception occurs.
 * 
 * @author Igor L Marques
 * 
 */ 
module LwBytecodeM
{
	provides
	{
		 interface TinyReefBytecode;
	}
	uses
	{
		interface TinyReefMemoryAccess as Memory;
		
		interface Leds;
	}
}

implementation
{
    command error_t TinyReefBytecode.execute(tinyReefContext_t* context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	5 bits	5 bits	16 bits
    	 * 100011	Rs		Rt 		offset
    	 * 
    	 * sample:
    	 * 100011	sssss	ttttt	iiiiiiiiiiiiiiii
		*/   
   
   		uint8_t	registerRS;
		uint8_t	registerRT;
		int16_t offset;
		
		uint32_t memAddr = 0x0;
		
		int8_t ret = FAIL;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - LwBytecodeM\n");
    	
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
    	
    	//multiple of WORD_LENGTH
    	if(0 == (memAddr % WORD_LENGTH))
    	{
    		context->registerFile[registerRT] = call Memory.getWord(context, memAddr);
    		
    		dbg("TinyReefBytecode", "context->registerFile[registerRT] = 0x%8X.\n", context->registerFile[registerRT]);

			ret = SUCCESS;
    	}
    	else
    	{
    		dbg("TinyReefBytecode", "The address are not a multiple of four -> memAddr = %d.\n", memAddr);
    	}
    
    	return ret;
    }
   
}