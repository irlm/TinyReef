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
 * Component SRL – Shift Right Logical:
 * srl Rd, Rt, sa # RF[Rd] = RF[Rt] >> sa
 *
 * @author Igor L Marques
 */ 
configuration SrlBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SrlBytecodeM;

	TinyReefBytecode = SrlBytecodeM.TinyReefBytecode;
}