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
 * ANDI -- Bitwise and immediate
 * aandi Rt, Rs, Imm # RF[Rt] = RF[Rs] AND Imm
 *
 * @author Igor L Marques
 */   
configuration AndIBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components AndIBytecodeM;

  	TinyReefBytecode = AndIBytecodeM.TinyReefBytecode;
}