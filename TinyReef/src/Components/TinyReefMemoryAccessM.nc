/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Jul 06, 2010.
 *
 */

#include "TinyReef.h"
#include "TinyReefMemory.h"

module TinyReefMemoryAccessM
{
	provides
	{
		interface TinyReefMemoryAccess as Memory;	
	}
}

implementation
{
	command uint8_t Memory.getByte(tinyReefContext_t *context, uint32_t addr)
	{
		uint8_t ret = 0x0;
		
		dbg("TinyReefMemoryAccess", "Memory.getByte().\n");
		
		//memcpy(&ret, &context->Memory[(addr - context->Offset) & 0xFFFF], sizeof(uint8_t));
		ret = context->Memory[(addr - context->Offset) & 0xFFFF];
		
		dbg("TinyReefMemoryAccess", "Memory addr = 0x%8X byte = 0x%2X.\n", (addr - context->Offset) & 0xFFFF, ret);	
		
		return ret;
	}

	command void Memory.setByte(tinyReefContext_t *context, uint32_t addr, uint8_t _byte)
	{
		dbg("TinyReefMemoryAccess", "Memory.setByte().\n");
		
		//memcpy(&context->Memory[(addr - context->Offset) & 0xFFFF], &_byte, sizeof(uint8_t));
		context->Memory[(addr - context->Offset) & 0xFFFF] = _byte;
		
		dbg("TinyReefMemoryAccess", "context->Memory[0x%8X] = 0x%2X.\n", (addr - context->Offset) & 0xFFFF,
		     context->Memory[(addr - context->Offset) & 0xFFFF]);	
	}
		
	command uint16_t Memory.getHalfWord(tinyReefContext_t* context, uint32_t addr)
	{
		uint16_t ret = 0x0;
		
		dbg("TinyReefMemoryAccess", "Memory.getHalfWord().\n");
		
		{//workaround
		int var;
    	for (var = 0; var < HALF_WORD_LENGTH; var++) {
    		dbg("TinyReefMemoryAccess", "context->Memory[0x%8X] = 0x%2X.\n",
    			(addr - context->Offset + var) & 0xFFFF,
    			(context->Memory[(addr - context->Offset + var) & 0xFFFF]));
    			
    	    ret |= (uint16_t)(((uint16_t)(context->Memory[(addr - context->Offset + var) & 0xFFFF])) << ((HALF_WORD_OFFSET-var) << HALF_WORD_OFFSET)); 	
    	}
    	}
		
		dbg("TinyReefMemoryAccess", "Memory.getHalfWord = 0x%4X.\n", ret);		

		return ret;
	}
    
    command void Memory.setHalfWord(tinyReefContext_t* context, uint32_t addr, uint16_t _halfWord)
    {
    	dbg("TinyReefMemoryAccess", "Memory.setHalfWord().\n");
    	
    	dbg("TinyReefMemoryAccess", "Memory.setHalfWord(0x%4X).\n", _halfWord);
    	
    	{//workaround
		int var;
    	for (var = 0; var < HALF_WORD_LENGTH; var++) {
    		
    		context->Memory[(addr - context->Offset + var) & 0xFFFF] = (uint8_t)( (0xFF) & (_halfWord >> ((HALF_WORD_OFFSET-var) << HALF_WORD_OFFSET)));
    		
    		dbg("TinyReefMemoryAccess", "context->Memory[0x%8X] = 0x%2X.\n",
    			(addr - context->Offset + var) & 0xFFFF,
    			((uint8_t)( (0xFF) & (_halfWord >> ((HALF_WORD_OFFSET-var) << HALF_WORD_OFFSET)))));;	
    	}
    	}
			
    }
    
	command uint32_t Memory.getWord(tinyReefContext_t *context, uint32_t addr)
	{
		uint32_t ret = 0x0;
		
		dbg("TinyReefMemoryAccess", "Memory.getWord().\n");
		
		{//workaround
		int var;
    	for (var = 0; var < WORD_LENGTH; var++) {
    		//destination |= ( context->Memory[memAddr + var]) << ((WORD_OFFSET-var) << WORD_OFFSET);
    		dbg("TinyReefMemoryAccess", "context->Memory[0x%8X] = 0x%2X.\n",
    			(addr - context->Offset + var) & 0xFFFF,
    			(context->Memory[(addr - context->Offset + var) & 0xFFFF]));
    			
    	    ret |= (uint32_t)(((uint32_t)(context->Memory[(addr - context->Offset + var) & 0xFFFF])) << (SHIFT_BYTE(var))); 	
    	}
    	}
		
		dbg("TinyReefMemoryAccess", "Memory.getWord = 0x%8X.\n", ret);		
		
		return ret; 
	}
	
	command void Memory.setWord(tinyReefContext_t *context, uint32_t addr, uint32_t _word)
	{
		dbg("TinyReefMemoryAccess", "Memory.setWord(0x%8X).\n", _word);
		
		{//workaround
		int var;
		for (var = 0; var < WORD_LENGTH; var++) {
    		
    		context->Memory[(addr - context->Offset + var) & 0xFFFF] = (uint8_t)( (0xFF) & (_word >> (SHIFT_BYTE(var))));	
    		
    		dbg("TinyReefMemoryAccess", "context->Memory[0x%8X] = 0x%2X.\n",
    			(addr - context->Offset + var) & 0xFFFF,
    			((uint8_t)( (0xFF) & (_word >> (SHIFT_BYTE(var))))));
    	}
    	}
    	
    }
	
}