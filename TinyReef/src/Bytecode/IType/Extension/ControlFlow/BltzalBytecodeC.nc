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
 * Component BLTZAL -- Branch on less than zero and link
 * bltzal Rs, Label # If RF[Rs] < RF[0] then
 * 							{RF[$ra] = PC;
 * 							 PC = PC + Imm<< 2 }
 *
 * @author Igor L Marques
 */   
configuration BltzalBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components BltzalBytecodeM;

  	TinyReefBytecode = BltzalBytecodeM.TinyReefBytecode;
}
