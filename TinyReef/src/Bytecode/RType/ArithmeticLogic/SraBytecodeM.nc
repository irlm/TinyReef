/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   May 02, 2010.
 *
 */

#include "TinyReef.h"

/**
 * TThe contents of Reg.File[Rt] are shifted right sa-bits, sign-extending the high order bits,
 * and the result is stored in Reg.File[Rd].
 *
 * @author Igor L Marques
 */  
module SraBytecodeM
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
    	 * 000000	00000	ttttt	ddddd	00000	000011
		*/
		
		uint8_t	registerRT;
		uint8_t	registerRD;
		uint8_t	sa;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - SraBytecodeM\n");
    	
    	//5 bits
    	registerRT = (uint8_t)(0x1F & (instruction >> 16));
    	dbg("TinyReefBytecode", "registerRT = %d \n", registerRT);
    	    	
    	//5 bits
    	registerRD = (uint8_t) (0x1F & (instruction >> 11));
    	dbg("TinyReefBytecode", "registerRD = %d \n", registerRD);
    	
    	//5 bits
    	sa = (uint8_t) (0x1F & (instruction >> 6));
    	dbg("TinyReefBytecode", "sa = %d \n", sa);
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRT] = %d \n", context->registerFile[registerRT]);
    	
    	context->registerFile[registerRD] = ((int32_t)context->registerFile[registerRT]) >> sa;
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRD] = %d \n", context->registerFile[registerRD]);	
    	
    	return SUCCESS;     	 
    }
       
}