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

configuration SendBytecodeC
{
	provides
	{
		interface TinyReefBytecode;
	}
}

implementation
{
	components SendBytecodeM;

	components CommunicationC;
	
	SendBytecodeM.TinyReefSend -> CommunicationC.TinyReefSend;
	 	
	components new InterpreterResourceC() as interpreter;

	SendBytecodeM.Resource -> interpreter.Resource;
	SendBytecodeM.TinyReefInterpreter -> interpreter.TinyReefInterpreter;
	
	components new TimerMilliC() as Timer0;
	
	SendBytecodeM.Timeout -> Timer0;
	
	TinyReefBytecode = SendBytecodeM;
}
