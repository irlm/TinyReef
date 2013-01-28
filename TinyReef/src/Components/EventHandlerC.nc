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

configuration EventHandlerC
{
	provides
	{
		interface TinyReefEventHandler as EventHandler;
	} 
}

implementation
{
	components EventHandlerM;
	
	components new InterpreterResourceC() as interpreter0;
	components new InterpreterResourceC() as interpreter1;
	components new InterpreterResourceC() as interpreter2;
	components new InterpreterResourceC() as interpreter3;
	components new InterpreterResourceC() as interpreter4;

	EventHandlerM.Resource[0] -> interpreter0.Resource;
	EventHandlerM.Resource[1] -> interpreter1.Resource;
	EventHandlerM.Resource[2] -> interpreter2.Resource;
	EventHandlerM.Resource[3] -> interpreter3.Resource;
	EventHandlerM.Resource[4] -> interpreter4.Resource;
	
	EventHandlerM.ResourceRequested[0] -> interpreter0.ResourceRequested;
	EventHandlerM.ResourceRequested[1] -> interpreter1.ResourceRequested;
	EventHandlerM.ResourceRequested[2] -> interpreter2.ResourceRequested;
	EventHandlerM.ResourceRequested[3] -> interpreter3.ResourceRequested;
	EventHandlerM.ResourceRequested[4] -> interpreter4.ResourceRequested;
	
	EventHandlerM.TinyReefInterpreter[0] -> interpreter0.TinyReefInterpreter;
	EventHandlerM.TinyReefInterpreter[1] -> interpreter1.TinyReefInterpreter;
	EventHandlerM.TinyReefInterpreter[2] -> interpreter2.TinyReefInterpreter;
	EventHandlerM.TinyReefInterpreter[3] -> interpreter3.TinyReefInterpreter;
	EventHandlerM.TinyReefInterpreter[4] -> interpreter4.TinyReefInterpreter;

	EventHandler = EventHandlerM.EventHandler;
}