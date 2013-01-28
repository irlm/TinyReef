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
 * Component Set on Less Than: (Used in branch macro instructions)
 * slt Rd, Rs, Rt # if (RF[Rs] < RF[Rt] ) then RF[Rd] =1 else RF[Rd] = 0
 *
 * @author Igor L Marques
 */ 
configuration SltBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SltBytecodeM;

	TinyReefBytecode = SltBytecodeM.TinyReefBytecode;
}