/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Set 23, 2009.
 *
 */

#include "TinyReef.h"

/**
 * 
 * Bit wise logically OR contents of Reg.File[Rs] wih zero extended Imm value and store
 * result in Reg.File[Rt].
 * 
 * @author Igor L Marques
 * 
 */  
module OrIBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{
    command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	5 bits	5 bits	16 bits
    	 * 001101	Rs		Rt 		Immediate
    	 * 
    	 * sample:
    	 * 001101	sssss	ttttt	iiiiiiiiiiiiiiii
		*/   
   
   		uint8_t	registerRS;
		uint8_t	registerRT;
		
		//wih zero-extended Imm
		uint32_t immediate	= 0x0;
			
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - OrIBytecodeM\n");
    	
    	//5 bits
    	registerRS = (uint8_t)(0x1F & (instruction >> 21));
    	dbg("TinyReefBytecode", "registerRS = %d \n", registerRS);
    	
    	//5 bits
    	registerRT = (uint8_t)(0x1F & (instruction >> 16));
    	dbg("TinyReefBytecode", "registerRT = %d \n", registerRT);
    	
    	//32 bits (the immediate 16 bits and the zero-extends)
    	immediate = (uint32_t)(0x0000FFFF & instruction);
    	dbg("TinyReefBytecode", "constant = %d \n", immediate);
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRS] = %d \n", context->registerFile[registerRS]);
    	
    	context->registerFile[registerRT] = context->registerFile[registerRS] | immediate;
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRT] = %d \n", context->registerFile[registerRT]);
    	
    	return SUCCESS;
    }
   
}