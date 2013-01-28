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
 
configuration InterpreterC
{
	provides
	{
		interface SplitControl;
		interface TinyReefInterpreter;
	}
}

implementation
{
	components InterpreterM;
	components EventHandlerC;
	components InstructionSetFullC;
	
	InterpreterM.Bytecode -> InstructionSetFullC.Bytecode;

#if defined(COMPILE_MICA2_TEST)		
	components LedsC;
	components new TimerMilliC() as Timer0;
	
	InterpreterM.Leds -> LedsC;
	InterpreterM.Timer0 -> Timer0; 
#endif
	
	SplitControl = InterpreterM;
	TinyReefInterpreter = InterpreterM;
}