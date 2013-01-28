/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/**
 * @author Igor L Marques
 * @date:   Mar 22, 2010.
 *
 */

configuration SenseBytecodeC
{
	provides
	{ 
		interface TinyReefBytecode;
	}
}

implementation
{
	components SenseBytecodeM;
	
	components TinyReefSenseC;
	
	components TinyReefMemoryAccessM;
	
	SenseBytecodeM.Memory -> TinyReefMemoryAccessM.Memory;
	
	SenseBytecodeM.Read -> TinyReefSenseC.Read;
	
	components new InterpreterResourceC() as interpreter;

	SenseBytecodeM.Resource -> interpreter.Resource;
	SenseBytecodeM.TinyReefInterpreter -> interpreter.TinyReefInterpreter;
	
	components new TimerMilliC() as Timer0;
	
	SenseBytecodeM.Timeout -> Timer0;
	
	TinyReefBytecode = SenseBytecodeM.TinyReefBytecode;
}