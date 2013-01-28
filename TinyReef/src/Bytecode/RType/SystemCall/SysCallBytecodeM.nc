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
 * A user program exception is not generated.
 * 
 * (Used to call system services to perform I/O)
 *
 * @author Igor L Marques
 */  
module SysCallBytecodeM
{
	provides interface TinyReefBytecode;
	
	uses
	{
		interface TinyReefBytecode as VMCall[uint8_t opcode];
		
		interface Leds;
	}
}

implementation
{
	command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	20 bits					6 bits
    	 * 000000	padding					Function code
    	 * 
    	 * sample:
    	 * 000000	00000000000000000000	001100
		*/
		
		uint8_t	syscall;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - SysCallBytecodeM\n");
    	
    	syscall = (uint8_t)context->registerFile[R_V0];
    	//context->registerFile[R_V0] = 0x0;
    	
    	dbg("TinyReefBytecode", "context->registerFile[R_V0] = 0x%2X\n", context->registerFile[R_V0]);
    	dbg("TinyReefBytecode", "syscall = 0x%2X\n", syscall);
    	
    	return call VMCall.execute[syscall](context, instruction);    	
    }
    
    default command error_t VMCall.execute[uint8_t opcode](tinyReefContext_t* context, uint32_t instruction)
   	{
   		dbg("TinyReefC", "SysCallBytecodeM - system call not implemented:%d.\n", opcode);
		
		//ignore the fail
		return FAIL;
   	}
       
}