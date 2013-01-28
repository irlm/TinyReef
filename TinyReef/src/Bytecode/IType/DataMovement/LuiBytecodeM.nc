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
 * 
 * The 16-bit immediate value is shifted left 16-bits concatenated with 16 zeros and loaded
 * into Reg.File[Rt].
 * 
 * ( This instruction in conjunction with an OR immediate
 * instruction is used to implement the Load Address pseudo instruction - la Label)
 * 
 * @author Igor L Marques
 * 
 */ 
module LuiBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{
    command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	5 bits	5 bits	16 bits
    	 * 001111	padding	Rt 		immediate
    	 * 
    	 * sample:
    	 * 001111	00000	ttttt	iiiiiiiiiiiiiiii
		*/   
   
   		uint8_t	registerRT;
		uint32_t immediate;
			
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - LuiBytecodeM\n");
    	
    	//5 bits
    	registerRT = (uint8_t)(0x1F & (instruction >> 16));
    	dbg("TinyReefBytecode", "registerRT = %d \n", registerRT);
    	
    	//16 bits
    	immediate = (uint16_t)(0xFFFF & instruction);
    	dbg("TinyReefBytecode", "immediate = 0x%4X \n", immediate);
    	
    	context->registerFile[registerRT] = ((immediate << 16) | 0x0000);
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRT] = 0x%8X \n", context->registerFile[registerRT]);
    
    	return SUCCESS;
    }
   
}