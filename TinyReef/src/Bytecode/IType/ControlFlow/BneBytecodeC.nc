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
 * Component BNE -- Branch on not equal
 * bne Rs, Rt, Label # If RF[Rs] != RF[Rt] then PC = PC + Imm<< 2
 *
 * @author Igor L Marques
 */  
configuration BneBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components BneBytecodeM;

  	TinyReefBytecode = BneBytecodeM.TinyReefBytecode;
}
