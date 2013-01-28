/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   May 04, 2010.
 *
 */
 
/**
 * Component SRLV – Shift Right Logical Variable:
 * srlv Rd, Rt, Rs # RF[Rd] = RF[Rt] >> RF[Rs] amount
 *
 * @author Igor L Marques
 */ 
configuration SrlvBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SrlvBytecodeM;

	TinyReefBytecode = SrlvBytecodeM.TinyReefBytecode;
}