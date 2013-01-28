/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Set 16, 2009.
 *
 */

#include "TinyReef.h"
#include "TinyReefMemory.h"
#include "TinyReefProcessState.h"

module InterpreterM @safe()
{
	provides
	{
		interface SplitControl;
		interface TinyReefInterpreter;
	}
	uses
	{
		interface TinyReefBytecode as Bytecode[uint8_t opcode];

#if defined(COMPILE_MICA2_TEST)		
		interface Leds;
		interface Timer<TMilli> as Timer0;
#endif
	}
}

implementation
{
	tinyReefContext_t *tinyReefContext;
	
	bool readInstruction_t(uint8_t *const opcode, uint32_t *const instruction);
	
	task void startDone()
	{
		signal SplitControl.startDone(SUCCESS);
	}
	  
	task void stopDone() 
	{
		signal SplitControl.stopDone(SUCCESS);
	}
	
	command error_t SplitControl.start()
	{
  		post startDone();
  		return  SUCCESS;
  	}
  
  	command error_t SplitControl.stop() 
  	{
  		post stopDone();
  		return  SUCCESS;
  	}
	
	task void runExecute()
	{
		bool retReadInstruction = TRUE;
		uint8_t opcode = 0x0;
		uint32_t instruction = 0x0;
		
		dbg("TinyReefC", "runExecute\n");	
		
		{//workaround
		int var;
#if defined(COMPILE_MICA2_TEST)		
		for (var = 0; var < 1; var++) {
#else
		for (var = 0; var < 20; var++) {
#endif			
			retReadInstruction = readInstruction_t(&opcode, &instruction);
			if(TRUE == retReadInstruction)
			{
				if(tinyReefContext != NULL && FAIL == call Bytecode.execute[opcode](tinyReefContext, instruction))
				{
					dbg("TinyReefC", "----------------- ERROR -----------------\n");
					
					if(tinyReefContext != NULL)
					{
						tinyReefContext->state = ZOOMBIED;
					}
					
					break;	
				}			
			}
			else
			{
				dbg("TinyReefC", "----------------- FALSE == retReadInstruction -----------------\n");
				break;
			}
		}			
		}
		
		if(tinyReefContext != NULL && ((ZOOMBIED == tinyReefContext->state) || (BLOCKED == tinyReefContext->state)))
		{
			dbg("TinyReefC", "signal TinyReefInterpreter.interpreterProgramDone(FAIL)\n");
			signal TinyReefInterpreter.interpreterProgramDone(FAIL);
		}
		else
		{
			if ((TRUE == retReadInstruction))
			{
				dbg("TinyReefC", "post runExecute()\n");
				
#if defined(COMPILE_MICA2_TEST)		
				call Timer0.startOneShot(500);
#else
				post runExecute();
#endif	
			}
			else
			{
				dbg("TinyReefC", "signal TinyReefInterpreter.interpreterProgramDone(SUCCESS)\n");
				signal TinyReefInterpreter.interpreterProgramDone(SUCCESS);	
			}	
		}
		
	}
	
	
	command error_t TinyReefInterpreter.interpreterProgram(tinyReefContext_t *const context)
	{
		if(context != NULL && context->state != BLOCKED)
		{
      		if (NEW == context->state)
			{
				dbg("TinyReefC", "--------- Go Go Go ---------\n");	
				
				context->PC = context->Offset;
				context->state = RUNNING;		
			}
  	  		
  	  		tinyReefContext = context;
		
#if defined(COMPILE_MICA2_TEST)		
			call Timer0.startOneShot(500);
#else
			post runExecute();
#endif	
			
			return SUCCESS;
  		}
  		else
  		{
  			dbg("TinyReefC", "--------- lock == TRUE ---------\n");
  		}
  	
  		return FAIL;  	
	}
	
	bool readInstruction_t(uint8_t *const opcode, uint32_t *const instruction)
	{
		bool ret = FALSE;
	
		if(tinyReefContext != NULL)
		{
			switch (tinyReefContext->state)
			{
				case STANDBY:
				case RUNNING:
					{
						uint16_t memAddr = ( 0xFFFF & (tinyReefContext->PC - tinyReefContext->Offset)); 
						dbg("TinyReefC", "pContext->PC : 0x%8X.\n", tinyReefContext->PC);
						dbg("TinyReefC", "memAddrC : 0x%8X.\n", memAddr);
						
						if(instruction != NULL)
						{
							*instruction = 0x0;
						}	
						else
						{
							return FALSE;
						}
						
						atomic{	
						uint8_t var;
						for (var = 0; var < WORD_LENGTH; var++) {
							if(tinyReefContext != NULL && (memAddr + var) < TINYREEF_PROGRAM_SEG_SIZE)
							{
								if(instruction != NULL)
								{
									*instruction |= ((uint32_t)( tinyReefContext->Memory[memAddr + var])) << ((WORD_OFFSET-var) << WORD_OFFSET);	
								}
								else
								{
									return FALSE;
								}
							}
							else
							{
								break;
							}
						}
						}
						
						if(opcode != NULL && instruction != NULL)
						{
							*opcode = (uint8_t)(*instruction >> 26);
						
							dbg("TinyReefC", "instruction:0x%8X.\n", *instruction);
							dbg("TinyReefC", "readInstruction_t opcode:0x%2X.\n", *opcode);
						}
						else
						{
							return FALSE;
						}
	  	
						tinyReefContext->PC = tinyReefContext->PC + 4;
						ret = TRUE;
					}
					break;
				case BLOCKED:
					ret = FALSE;
					break;
				case SUSPENDED_BLOCKED:
					ret = TRUE;
					break;
				case DONE_TERMINATED:
					dbg("TinyReefC", "--------- BYE ---------\n");
					ret = FALSE;
					break;
				case BLOCKED | DONE_TERMINATED:	
				case STANDBY | DONE_TERMINATED:
					dbg("TinyReefC", "--------- Waiting events ---------\n");
					tinyReefContext->state = STANDBY;
					ret = FALSE;
					break;	
				default:
					tinyReefContext->state = ZOOMBIED;
					ret = FALSE;
					break;
			}
		}
		
		return ret;		
	}
	
	default command error_t Bytecode.execute[uint8_t opcode](tinyReefContext_t *const context, uint32_t instruction)
    {
		dbg("TinyReefC", "Bytecode Invalid opcode:%X.\n", opcode);
	
		return FAIL;
    }

#if defined(COMPILE_MICA2_TEST)		
	event void Timer0.fired()
	{
		call Leds.led1Toggle();
		post runExecute();	  
	}
#endif	


}