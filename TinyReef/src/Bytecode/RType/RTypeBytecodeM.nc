/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Apr 24, 2010.
 *
 */

#include "TinyReef.h"

/**
 * 	This group contains all instructions that do not require an immediate value,
 * target offset, memory address displacement, or memory address to specify an operand.
 * This includes arithmetic and logic with all operands in registers, shift instructions,
 * and register direct jump instructions (jalr and jr).
 *  
 * @author Igor L Marques
 */  
module RTypeBytecodeM
{
	provides interface TinyReefBytecode;
	
	uses
	{
		interface TinyReefBytecode as Functions[uint8_t opcode];
	}
}

implementation
{
    command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits		20 bits					6 bits
    	 * 000000		param		  			Function code
    	 * 
    	 * sample:
    	 * 000000		xxxxxxxxxxxxxxxxxxxx	100000
		*/
		
		uint8_t	function;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - FunctionBytecodeM\n");
    	
    	//6 bits
    	function = (uint8_t)(0x3F & (instruction));
    	dbg("TinyReefBytecode", "function = %2X \n", function);
    
    	return call Functions.execute[function](context, instruction);	
    }
    
    default command error_t Functions.execute[uint8_t opcode](tinyReefContext_t* context, uint32_t instruction)
   	{
   		dbg("TinyReefC", "FunctionBytecodeM - Invalid function:%d.\n", opcode);
		return FAIL;
   	}
       
}