/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Jul 16, 2010.
 *
 */

module InterpreterResourceImplP
{
	provides
	{
    	interface TinyReefInterpreter as SharedTinyReefInterpreters[uint8_t id];
  	}
  	uses
  	{
  		interface ArbiterInfo;
  		interface TinyReefInterpreter;
 	}
}

implementation
{
	uint8_t current_id = 0xFF;
  
  	event void TinyReefInterpreter.interpreterProgramDone(error_t error)
  	{
  		dbg("TinyReefC", "TinyReefInterpreter.interpreterProgramDone\n");
  		signal SharedTinyReefInterpreters.interpreterProgramDone[current_id](error);
  	}
  
  	command error_t SharedTinyReefInterpreters.interpreterProgram[uint8_t id](tinyReefContext_t* context)
  	{
  		dbg("TinyReefC", "SharedTinyReefInterpreters.interpreterProgram[%d]\n", id);
  		
  		if(	(id == call ArbiterInfo.userId()) &&
  		  	(SUCCESS == call TinyReefInterpreter.interpreterProgram(context)))
  		{
      		current_id = id;
      		dbg("TinyReefC", "SharedTinyReefInterpreters.interpreterProgram == SUCCESS\n");
  	  		return SUCCESS;
  		}
  		else
  		{
  			dbg("TinyReefC", "SharedTinyReefInterpreters.interpreterProgram == FAIL\n");
  		}
  		
  		return FAIL;
  	}
  
  	default event void SharedTinyReefInterpreters.interpreterProgramDone[uint8_t id](error_t error)
  	{
  		dbg("TinyReefC", "default event void TinyReefInterpreters.interpreterProgramDone\n");
  	}
}

