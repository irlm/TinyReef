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
 * Component SRA – Shift Right Arithmetic:
 * sra Rd, Rt, sa # RF[Rd] = RF[Rt] >> sa
 *
 * @author Igor L Marques
 */ 
configuration SraBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SraBytecodeM;

	TinyReefBytecode = SraBytecodeM.TinyReefBytecode;
}