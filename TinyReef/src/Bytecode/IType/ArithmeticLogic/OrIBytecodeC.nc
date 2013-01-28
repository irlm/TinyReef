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
 * ORI -- OR Immediate:
 * ori Rt, Rs, Imm # RF[Rt] = RF[Rs] OR Imm
 *
 * @author Igor L Marques
 */  
configuration OrIBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components OrIBytecodeM;

  	TinyReefBytecode = OrIBytecodeM.TinyReefBytecode;
}