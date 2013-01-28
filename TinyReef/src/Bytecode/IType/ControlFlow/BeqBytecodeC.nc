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
 * Component EQ -- Branch on equal
 * Beq Rs, Rt, Label # If (RF[Rs] == RF[Rt] )then PC = PC + Imm<< 2
 *
 * @author Igor L Marques
 */    
configuration BeqBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components BeqBytecodeM;

  	TinyReefBytecode = BeqBytecodeM.TinyReefBytecode;
}
