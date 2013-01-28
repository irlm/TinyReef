/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Aug 16, 2009.
 *
 */
 

#include "TinyReefProcessState.h"
#include "TinyReefEvent.h"

module EventHandlerM @safe()
{
	provides
	{
		interface TinyReefEventHandler as EventHandler;
	} 
	
	uses
	{
		interface Resource as Resource[uint8_t id];
		interface ResourceRequested as ResourceRequested[uint8_t id];
		interface TinyReefInterpreter as TinyReefInterpreter[uint8_t id];
	}
}

implementation
{	
	eventTableEntry_t ONE eventTable[MAX_EVENT_TABLE];
	
	tinyReefContext_t* ONE_NOK tinyReefContext;
	uint8_t tinyReefEventID = 0;

	command error_t EventHandler.executeEvent(uint8_t eventId)
	{
		dbg("TinyReefEventHandler", "Call EventHandler.executeEvent = %d.\n", eventId);
		
		if ((eventId < MAX_EVENT_TABLE) && (SUCCESS == eventTable[eventId].error))
		{
			dbg("TinyReefEventHandler", "call Resource.request[%d].\n", eventId);
			return call Resource.request[eventId]();
		}
		else
		{
			dbg("TinyReefEventHandler", "Call EventHandler.executeEvent FAIL.\n");
			return FAIL;
		}
	}

	command error_t EventHandler.registerEvent(tinyReefContext_t *const context, uint32_t handlerAddress,
		uint32_t endEventAddress, uint8_t *id)
	{
		if (tinyReefEventID < MAX_EVENT_TABLE && context != NULL)
		{
			if(id != NULL)
			{ 
				dbg("TinyReefEventHandler", "registerEvent(%d, 0x%8X, 0x%8X).\n", tinyReefEventID, handlerAddress, endEventAddress);
				
				tinyReefContext = context; 
				tinyReefContext->state = STANDBY;
			
				*id = eventTable[tinyReefEventID].eventId	= tinyReefEventID;
				eventTable[tinyReefEventID].handlerAddress 	= handlerAddress;
				eventTable[tinyReefEventID].endEventAddress = endEventAddress;
				eventTable[tinyReefEventID].error			= SUCCESS;
				
				tinyReefEventID++;
			}
			
			return SUCCESS;
		}
				
		return FAIL;
	}

	event void Resource.granted[uint8_t id]()
	{
		if (id < MAX_EVENT_TABLE && tinyReefContext != NULL)
		{
			if((tinyReefContext != NULL) && (BLOCKED != tinyReefContext->state))
			{
				dbg("TinyReefEventHandler", "executeEvent %d in address 0x%8X with endEventAddress 0x%8X.\n",
					id, eventTable[id].handlerAddress,  eventTable[id].endEventAddress);
			
				tinyReefContext->registerFile[R_RA] = eventTable[id].endEventAddress;
			
				tinyReefContext->PC = eventTable[id].handlerAddress;
			
				tinyReefContext->state = STANDBY;
			
				call TinyReefInterpreter.interpreterProgram[id](tinyReefContext);
			}
			else
			{
				dbg("TinyReefEventHandler", "executeEvent TinyReefInterpreter.interpreterProgram = BLOCKED.\n");
			}			
		}
		else
		{
			dbg("TinyReefEventHandler", "executeEvent %d NOT SUPPORTED.\n", id);
		}
		
	}
	

	event void TinyReefInterpreter.interpreterProgramDone[uint8_t id](error_t error)
	{
		dbg("TinyReefEventHandler", "TinyReefInterpreter.interpreterProgramDone[%d].\n", id);
		
		if (id < MAX_EVENT_TABLE)
		{
			if((tinyReefContext != NULL) && (BLOCKED == tinyReefContext->state))
			{
				dbg("TinyReefEventHandler", "TinyReefInterpreter.interpreterProgramDone[%d] = BLOCKED.\n", id);
				eventTable[id].error = SUCCESS;
			}
			else
			{
				dbg("TinyReefEventHandler", "TinyReefInterpreter.interpreterProgramDone[%d] = error = %d.\n", id, error);
				eventTable[id].error = error;
			}	
		}
		
		call Resource.release[id]();
	}
	
	async event void ResourceRequested.immediateRequested[uint8_t id]()
	{
		dbg("TinyReefEventHandler", "-----------------ResourceRequested.immediateRequested[%d].\n", id);
	}

	async event void ResourceRequested.requested[uint8_t id]()
	{
		dbg("TinyReefEventHandler", "ResourceRequested.requested[%d].\n", id);
		dbg("TinyReefEventHandler", "call Resource.release[%d].\n", id);
		
		call Resource.release[id]();
	}
	
	default async command error_t Resource.request[uint8_t id]()
	{
		dbg("TinyReefEventHandler", "ERROR Resource.request[%d].\n", id);
		return FAIL;
	}
	
	default async command error_t Resource.release[uint8_t id]()
	{
		dbg("TinyReefEventHandler", "ERROR Resource.release[%d].\n", id);
		return FAIL;
	}
	
	default command error_t TinyReefInterpreter.interpreterProgram[uint8_t id](tinyReefContext_t* context)
	{
		dbg("TinyReefEventHandler", "ERROR TinyReefInterpreter.interpreterProgram[%d].\n", id);
		return FAIL;
	}
}