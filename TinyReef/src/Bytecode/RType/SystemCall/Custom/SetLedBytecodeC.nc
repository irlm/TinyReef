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

configuration SetLedBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SetLedBytecodeM, LedsC;

	SetLedBytecodeM.Leds -> LedsC.Leds;
	TinyReefBytecode = SetLedBytecodeM.TinyReefBytecode;
}