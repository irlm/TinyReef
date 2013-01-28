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
 *
 * @author Igor L Marques
 */  
module ExtensionBytecodeM
{
	provides interface TinyReefBytecode;
	
	uses
	{
		interface TinyReefBytecode as Codes[uint8_t opcode];
	}
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
		
		uint8_t	code;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - CodeBytecodeM\n");
    	
    	//6 bits
    	code = (uint8_t)(0x1F & ( instruction >> 16));
    	
    	dbg("TinyReefBytecode", "code = %d \n", code);
    
    	return call Codes.execute[code](context, instruction);
   }
   
   default command error_t Codes.execute[uint8_t opcode](tinyReefContext_t* context, uint32_t instruction)
   {
   		dbg("TinyReefC", "CodeBytecodeM - Invalid code:%d.\n", opcode);
		return FAIL;
   }
       
}