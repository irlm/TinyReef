/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   May 04, 2010.
 *
 */
 
/**
 * Component SLTI -- Set on Less Than Immediate: (Used in branch macro instructions)
 * slti Rt, Rs, Imm # if (RF[Rs] < Imm ) then RF[Rt] =1 else RF[Rt] = 0
 *
 * @author Igor L Marques
 */  
configuration SltiBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SltiBytecodeM;

  	TinyReefBytecode = SltiBytecodeM.TinyReefBytecode;
}