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
 * If the contents of Reg.File[Rs] are less than the sign-extended immediate value then
 * Reg.File[Rt] is set to one, otherwise Reg.File[Rt] is set to zero; assuming the two’s
 * complement number system representation.
 * 
 * @author Igor L Marques
 * 
 */ 
module SltiBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{
    command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	5 bits	5 bits	16 bits
    	 * 001010	Rs		Rt 		immediate
    	 * 
    	 * sample:
    	 * 001010	sssss	ttttt	iiiiiiiiiiiiiiii
		*/   
   
   		uint8_t	registerRS;
   		uint8_t	registerRT;
		int32_t immediate;
			
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - SltiBytecodeM\n");
    	
    	//5 bits
    	registerRS = (uint8_t)(0x1F & (instruction >> 21));
    	dbg("TinyReefBytecode", "registerRS = %d \n", registerRS);
    	
    	//5 bits
    	registerRT = (uint8_t)(0x1F & (instruction >> 16));
    	dbg("TinyReefBytecode", "registerRT = %d \n", registerRT);
    	
    	//16 bits
    	immediate = (int32_t)(0xFFFF & instruction);
    	dbg("TinyReefBytecode", "immediate = %d \n", immediate);
    	
    	if (context->registerFile[registerRS] < immediate )
    	{
    		context->registerFile[registerRT] = 1; 
    	}
    	else
    	{
    		 context->registerFile[registerRT] = 0;
    	}
        	
    	dbg("TinyReefBytecode", "context->registerFile[registerRT] = %d \n", context->registerFile[registerRT]);	
    	
    	return SUCCESS;
    }
   
}