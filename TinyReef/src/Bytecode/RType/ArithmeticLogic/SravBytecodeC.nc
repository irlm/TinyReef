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
 * Component SRAV – SShift Right Arithmetic Variable:
 * srav Rd, Rt, Rs # RF[Rd] = RF[Rt] >> RF[Rs] amount
 *
 * @author Igor L Marques
 */ 
configuration SravBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SravBytecodeM;

	TinyReefBytecode = SravBytecodeM.TinyReefBytecode;
}