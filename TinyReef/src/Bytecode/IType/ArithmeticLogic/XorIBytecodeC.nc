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
 * XORI -- Exclusive OR Immediate:
 * xori Rt, Rs, Imm # RF[Rt] = RF[Rs] XOR Imm
 *
 * @author Igor L Marques
 */  
configuration XorIBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components XorIBytecodeM;

  	TinyReefBytecode = XorIBytecodeM.TinyReefBytecode;
}