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
 * Component SLL – Shift Left Logical:
 * sll Rd, Rt, sa # RF[Rd] = RF[Rt] << sa
 *
 * @author Igor L Marques
 */ 
configuration SllBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SllBytecodeM;

	TinyReefBytecode = SllBytecodeM.TinyReefBytecode;
}