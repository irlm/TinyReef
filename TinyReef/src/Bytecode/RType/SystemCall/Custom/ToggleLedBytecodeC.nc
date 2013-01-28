/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Set 24, 2009.
 *
 */

configuration ToggleLedBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components ToggleLedBytecodeM, LedsC;

	ToggleLedBytecodeM.Leds -> LedsC.Leds;
	TinyReefBytecode = ToggleLedBytecodeM.TinyReefBytecode;
}