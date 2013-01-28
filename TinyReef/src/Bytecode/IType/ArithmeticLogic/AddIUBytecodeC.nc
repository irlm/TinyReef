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
 * ADDIU -- Add immediate unsigned (no overflow)
 * addiu Rt, Rs, Imm # RF[Rt] = RF[Rs] + Imm
 *
 * @author Igor L Marques
 */  
configuration AddIUBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components AddIUBytecodeM;

  	TinyReefBytecode = AddIUBytecodeM.TinyReefBytecode;
}