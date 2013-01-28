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

/**
 * The contents of Reg.File[Rt] are shifted left sa-bits & the result is stored in Reg.File[Rd].
 *
 * @author Igor L Marques
 */  
module SllBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{
	command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	5 bits	5 bits	5 bits	5 bits	6 bits
    	 * 000000	padding	Rt 		Rd		sa		Function code
    	 * 
    	 * sample:
    	 * 000000	00000	ttttt	ddddd	00000	000000
		*/
		
		uint8_t	registerRT;
		uint8_t	registerRD;
		uint8_t	sa;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - SllBytecodeM\n");
    	
    	//5 bits
    	registerRT = (uint8_t)(0x1F & (instruction >> 16));
    	dbg("TinyReefBytecode", "registerRT = %d \n", registerRT);
    	    	
    	//5 bits
    	registerRD = (uint8_t) (0x1F & (instruction >> 11));
    	dbg("TinyReefBytecode", "registerRD = %d \n", registerRD);
    	
    	//5 bits
    	sa = (uint8_t) (0x1F & (instruction >> 6));
    	dbg("TinyReefBytecode", "sa = %d \n", sa);
    	
    	//verify special case... no operation 0x00000000
    	if(0 == (registerRD + registerRT + sa))
    	{
    		dbg("TinyReefC", "---------------NOP----------------\n");
    	}
    	else
    	{
    		dbg("TinyReefBytecode", "context->registerFile[registerRT] = %d \n", context->registerFile[registerRT]);
    	
    		context->registerFile[registerRD] = context->registerFile[registerRT] << sa;
    	
    		dbg("TinyReefBytecode", "context->registerFile[registerRD] = %d \n", context->registerFile[registerRD]);	
    	}
    		
    	return SUCCESS;     	 
    }
       
}