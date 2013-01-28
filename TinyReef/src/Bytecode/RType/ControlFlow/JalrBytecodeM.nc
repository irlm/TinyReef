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

/**
 * Save the current value of the Program Counter (PC) in Reg.File[Rd] and load the PC with
 * the address that is in Reg.File[Rs]. A programmer must insure a valid address has been
 * loaded into Reg.File[Rs] before executing this instruction.
 * 
 * (Use this instructions to make function calls.)
 *
 * @author Igor L Marques
 */  
module JalrBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{
    command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	5 bits	5 bits	5 bits	5 bits	6 bits
    	 * 000000	Rs		padding	Rd		padding	Function code
    	 * 
    	 * sample:
    	 * 000000	sssss	00000	ddddd	00000	001001
		*/
		
		uint8_t	registerRS;
		
		uint8_t	registerRD;		
				
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - JalrBytecodeM\n");
    	
    	//5 bits
    	registerRS = (uint8_t)(0x1F & (instruction >> 21));
    	dbg("TinyReefBytecode", "registerRS = %d \n", registerRS);
    	
    	//5 bits
    	registerRD = (uint8_t) (0x1F & (instruction >> 11));
    	dbg("TinyReefBytecode", "registerRD = %d \n", registerRD);
    	
    	context->registerFile[registerRD] = context->PC;
 
    	dbg("TinyReefBytecode", "context->registerFile[registerRD] = 0x%8X \n", context->registerFile[registerRD]); 
 
    	dbg("TinyReefBytecode", "context->registerFile[registerRS] = 0x%8X \n", context->registerFile[registerRS]);
    	
    	context->PC = context->registerFile[registerRS];
    	
    	return SUCCESS;    	
    }
       
}