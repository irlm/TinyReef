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
 * Component BLEZ -- Branch on less than or equal to zero
 * blez Rs, Label # If (RF[Rs] <= RF[0]) then PC = PC + Imm<< 2
 *
 * @author Igor L Marques
 */ 
configuration BlezBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components BlezBytecodeM;

  	TinyReefBytecode = BlezBytecodeM.TinyReefBytecode;
}
