/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Set 23, 2009.
 *
 */
 
/**
 * Component AND -- Bitwise and.
 * and Rd, Rs, Rt # RF[Rd] = RF[Rs] AND RF[Rt]
 *
 * @author Igor L Marques
 */  
configuration AndBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components AndBytecodeM;

  	TinyReefBytecode = AndBytecodeM.TinyReefBytecode;
}