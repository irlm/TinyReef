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
 * If Reg.File[Rs] is greater than or equal to zero, then branch to label.
 * 
 * @author Igor L Marques
 * 
 */ 
module BgezBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{

	command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
	{
		/*
    	 * 6 bits	5 bits	5 bits	16 bits
    	 * 000001	Rs		code	Immediate
    	 * 
    	 * sample:
    	 * 000001	sssss	00001	iiiiiiiiiiiiiiii
		*/  
   
   		uint8_t	registerRS;
		int16_t immediate;
			
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - BgezBytecodeM\n");
    	
    	//5 bits
    	registerRS = (uint8_t)(0x1F & (instruction >> 21));
    	dbg("TinyReefBytecode", "registerRS = %d \n", registerRS);
    	
    	//16 bits
    	immediate = (int16_t)(0xFFFF & instruction);
    	dbg("TinyReefBytecode", "constant = %d \n", immediate);
    	
    	dbg("TinyReefBytecode", "context->registerFile[registerRS] = %d \n", context->registerFile[registerRS]);
    	
    	//compare the two registers
    	if(0 == context->registerFile[registerRS])
    	{
    		dbg("TinyReefBytecode", "Before -> PC = %d \n", context->PC);
    		
    		/*
    		 * The immediate field contains a signed 16-bit value specifying the number of words away
    		 * from the current program counter address to the location symbolically specified by the
    		 * label.
    		 */
    		context->PC = context->PC + (immediate << 2);
    		
    		dbg("TinyReefBytecode", "After -> PC = %d \n", context->PC);	
    	}
    	
    	return SUCCESS;
	}
}