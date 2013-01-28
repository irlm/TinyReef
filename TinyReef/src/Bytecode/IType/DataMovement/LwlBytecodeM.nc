/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   May 03, 2010.
 *
 */

#include "TinyReef.h"
#include "TinyReefMemory.h"

/**
 * 
 * The 16-bit offset is sign extended and added to Reg.File[Rs] to form an effective byte
 * address. From one to four bytes will be loaded left justified into Reg.File[Rt] beginning
 * with the effective byte address then it proceeds toward a lower order byte in memory,
 * until it reaches the lowest order byte of the word in memory. This instruction can be used
 * in combination with the LWR instruction to load a register with four consecutive bytes
 * from memory, when the bytes cross a boundary between two words.
 * 
 * @author Igor L Marques
 * 
 */ 
module LwlBytecodeM
{
	provides interface TinyReefBytecode;
}

implementation
{
    command error_t TinyReefBytecode.execute(tinyReefContext_t *const context, uint32_t instruction)
    {
    	/*
    	 * 6 bits	5 bits	5 bits	16 bits
    	 * 100011	Rs		Rt 		offset
    	 * 
    	 * sample:
    	 * 100011	sssss	ttttt	iiiiiiiiiiiiiiii
		*/   
   
   		uint8_t	registerRS;
		uint8_t	registerRT;
		int16_t offset;
		
		uint32_t memAddr;
		
		int effectiveByteAddress;
		int var;
		
		uint32_t destination = 0x0;
		
		dbg("TinyReefBytecode", "TinyReefBytecode.execute - LwlBytecodeM\n");
    	
    	//5 bits
    	registerRS = (uint8_t)(0x1F & (instruction >> 21));
    	dbg("TinyReefBytecode", "registerRS = %d \n", registerRS);
    	
    	//5 bits
    	registerRT = (uint8_t)(0x1F & (instruction >> 16));
    	dbg("TinyReefBytecode", "registerRT = %d \n", registerRT);
    	
    	//16 bits
    	offset = (int16_t)(0xFFFF & instruction);
    	dbg("TinyReefBytecode", "offset = %d \n", offset);
    	
    	memAddr = (context->registerFile[registerRS] + offset) & 0xFFFF; 
    	
    	effectiveByteAddress = (int8_t) (memAddr % WORD_LENGTH);
    	
    	destination &= ~(MASK( (WORD_OFFSET - effectiveByteAddress)));
	
		for (var = effectiveByteAddress; var < WORD_LENGTH; var++) {
			destination |= ( context->Memory[memAddr + var]) << ((WORD_OFFSET-var) << WORD_OFFSET);	
		}
    		
    	context->registerFile[registerRT] = destination;
    		
    	dbg("TinyReefBytecode", "context->registerFile[registerRT] = %d.\n", context->registerFile[registerRT]);
    		
    	return SUCCESS;
    }
   
}