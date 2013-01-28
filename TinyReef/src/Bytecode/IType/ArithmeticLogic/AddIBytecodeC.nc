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
 * Component ADDI -- Add immediate (with overflow)
 * addi Rt, Rs, Imm 	# RF[Rt] = RF[Rs] + Imm
 *
 * @author Igor L Marques
 */  
configuration AddIBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components AddIBytecodeM;

  	TinyReefBytecode = AddIBytecodeM.TinyReefBytecode;
}