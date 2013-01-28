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
#include "TinyReefMemory.h"

/**
 * 
 * The 16-bit offset is sign extended and added to Reg.File[Rs] to form an effective address.
 * The contents of Reg.File[Rt ] are stored in memory at the effective address. If the least
 * two significant bits of the effective address are not zero, an address error exception
 * occurs. There are four bytes in a word, so word addresses must be binary numbers that
 * are a multiple of four, otherwise an address error exception occurs.
 * 
 * @author Igor L Marques
 * 
 */ 
module SwBytecodeM
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
    	 * 100001	Rs		Rt 		offset
    	 * 
    	 * sample:
    	 * 101011	sssss	ttttt	iiiiiiiiiiiiiiii
		*/   
   
   		uint8_t	registerRS;
		uint8_t	registerRT;
		int16_t offset;
		
		uint32_t memAddr = 0x0;
		uint32_t _word = 0x0;
		
		int8_t ret = FAIL;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - SwBytecodeM\n");
    	
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
    	
    	_word = context->registerFile[registerRT];
    	
    	if(0 == (memAddr % WORD_LENGTH))
    	{
    		dbg("TinyReefBytecode", "context->registerFile[registerRT] = 0x%8X \n", context->registerFile[registerRT]);

	    	call Memory.setWord(context, memAddr, _word);
	    	    		 		
    		ret = SUCCESS;
    	}
    	else
    	{
    		dbg("TinyReefBytecode", "If the effective address is an odd number -> memAddr = 0x%8X \n", memAddr);
    	}
    
    	return ret;
    }
   
}