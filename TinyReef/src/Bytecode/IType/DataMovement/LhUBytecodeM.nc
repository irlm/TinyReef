/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Apr 26, 2010.
 *
 */

#include "TinyReef.h"
#include "TinyReefMemory.h"

/**
 * 
 * The 16-bit offset is sign extended and added to Reg.File[Rs] to form an effective address.
 * A 16-bit half word is read from memory at the effective address, zero extended and
 * loaded into Reg.File[Rt]. If the effective address is an odd number, an address error
 * exception occurs.
 * 
 * @author Igor L Marques
 * 
 */ 
module LhUBytecodeM
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
    	 * 100101	Rs		Rt 		offset
    	 * 
    	 * sample:
    	 * 100101	sssss	ttttt	iiiiiiiiiiiiiiii
		*/   
   
   		uint8_t	registerRS;
		uint8_t	registerRT;
		int16_t offset;
		
		uint32_t memAddr = 0x0;
		
		int8_t ret = FAIL;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - LhUBytecodeM\n");
    	
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
    	
    	if(0 == (memAddr % HALF_WORD_LENGTH))
    	{
    		context->registerFile[registerRT] = (uint16_t) call Memory.getHalfWord(context, memAddr);
    		
    		dbg("TinyReefBytecode", "context->registerFile[registerRT] = 0x%8X.\n", context->registerFile[registerRT]);

			ret = SUCCESS;		
    	}
    	else
    	{
    		dbg("TinyReefBytecode", "If the effective address is an odd number -> memAddr = %d \n", memAddr);
    	}
    
    	return ret;
    }
   
}