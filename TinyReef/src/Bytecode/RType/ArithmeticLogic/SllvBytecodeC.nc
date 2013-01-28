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
 
/**
 * Component SLLV – Shift Left Logical Variable:
 * sllv Rd, Rt, Rs # RF[Rd] = RF[Rt] << RF[Rs] amount
 *
 * @author Igor L Marques
 */ 
configuration SllvBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SllvBytecodeM;

	TinyReefBytecode = SllvBytecodeM.TinyReefBytecode;
}