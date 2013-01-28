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
 * The contents of Reg.File[Rt] are shifted right, sign-extending the high order bits, by the
 * number of bits specified by the low order 5-bits of Reg.File[Rs], and the result is stored
 * in Reg.File[Rd].
 *
 * @author Igor L Marques
 */  
module SravBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{
	command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	5 bits	5 bits	5 bits	5 bits	6 bits
    	 * 000000	Rs		Rt 		Rd		padding	Function code
    	 * 
    	 * sample:
    	 * 000000	sssss	ttttt	ddddd	00000	000111
		*/
		
		uint8_t	registerRS;
		uint8_t	registerRT;
		uint8_t	registerRD;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - SravBytecodeM\n");
    	
    	//5 bits
    	registerRS = (uint8_t)(0x1F & (instruction >> 21));
    	dbg("TinyReefBytecode", "registerRS = %d \n", registerRS);
    	
    	//5 bits
    	registerRT = (uint8_t)(0x1F & (instruction >> 16));
    	dbg("TinyReefBytecode", "registerRT = %d \n", registerRT);
    	    	
    	//5 bits
    	registerRD = (uint8_t) (0x1F & (instruction >> 11));
    	dbg("TinyReefBytecode", "registerRD = %d \n", registerRD);
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRS] = %d \n", context->registerFile[registerRS]);
    	dbg("TinyReefBytecode", "context->registerFile[registerRT] = %d \n", context->registerFile[registerRT]);
    	
    	
    	context->registerFile[registerRD] = ((int32_t)context->registerFile[registerRS]) >> ( 0x1F & context->registerFile[registerRT]);
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRD] = %d \n", context->registerFile[registerRD]);	
    	
    	return SUCCESS;     	 
    }
       
}