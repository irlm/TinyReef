/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Jul 20, 2010.
 *
 */

configuration SetLedStateBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SetLedStateBytecodeM, LedsC;

	SetLedStateBytecodeM.Leds -> LedsC.Leds;
	TinyReefBytecode = SetLedStateBytecodeM.TinyReefBytecode;
}