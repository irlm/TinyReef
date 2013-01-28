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

configuration LoaderC
{
	provides
	{		
		command void load(uint8_t version);	
	}
}

implementation
{
	components LoaderM;
	components StorageProgramC;
	
	components new InterpreterResourceC() as interpreter;

	LoaderM.Resource -> interpreter.Resource;
	LoaderM.TinyReefInterpreter -> interpreter.TinyReefInterpreter;
	
	LoaderM.persistence -> StorageProgramC;
	
#if defined(COMPILE_WITH_TEST)	
	components LedsC;
  	components new TimerMilliC() as Timer0;
  	
  	LoaderM.Leds -> LedsC;
  	LoaderM.Timer0 -> Timer0;  		
#endif

	load = LoaderM.load;		
}