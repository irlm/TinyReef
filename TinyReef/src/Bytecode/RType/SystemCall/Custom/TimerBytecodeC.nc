/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques, Jobson Ronan
 * History:   Set 8, 2009.
 *
 */
 
configuration TimerBytecodeC
{
	provides
	{
		interface TinyReefBytecode;
	}
}

implementation
{
	components TimerBytecodeM;
  	components EventHandlerC;
  	
  	components new TimerMilliC() as Timer0;
	components new TimerMilliC() as Timer1;
	components new TimerMilliC() as Timer2;
	components new TimerMilliC() as Timer3;
	components new TimerMilliC() as Timer4;
  
    TimerBytecodeM.TimerMilli[0] -> Timer0;
    TimerBytecodeM.TimerMilli[1] -> Timer1;
    TimerBytecodeM.TimerMilli[2] -> Timer2;
    TimerBytecodeM.TimerMilli[3] -> Timer3;
    TimerBytecodeM.TimerMilli[4] -> Timer4;
  
	TimerBytecodeM.EventHandler -> EventHandlerC.EventHandler;
	
	TinyReefBytecode = TimerBytecodeM;
}