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
 * Save the current value of the Program Counter (PC) in Reg.File[$ra], and load the PC
 * with an address formed by concatenating the first 4-bits of the current PC with the value
 * in the 26-bit immediate field shifted left 2-bits.
 * 
 * @author Igor L Marques
 * 
 */  
module JalBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{

	command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
	{
		/*
    	 * 6 bits	26 bits
    	 * 000010	Immediate
    	 * 
    	 * sample:
    	 * 000011	iiiiiiiiiiiiiiiiiiiiiiiiii
		*/   
   
   		uint32_t immediate;
			
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - JalBytecodeM\n");
    	
    	//26 bits
    	immediate = (uint32_t)(0x3FFFFFF & instruction);
    	dbg("TinyReefBytecode", "constant = %d \n", immediate);
    	
    	dbg("TinyReefBytecode", "Before -> PC = %d \n", context->PC);
    	
    	//Save the current value of the Program Counter (PC)
    	context->registerFile[R_RA] = context->PC;
    		
		/*
		 * The immediate field contains a signed 16-bit value specifying the number of words away
		 * from the current program counter address to the location symbolically specified by the
		 * label.
		 */
		context->PC = (context->PC & 0xF0000000) | (immediate << 2);
		
		context->PC &=  0xFFFF; 
		
		dbg("TinyReefBytecode", "After -> PC = %d \n", context->PC);
		
		return SUCCESS;
	}
}