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
 * Component SLTIU -- Set on Less Than Immediate Unsigned: (Used in branch macro instructions)
 * sltiu Rt, Rs, Imm # if (RF[Rs] < Imm ) then RF[Rt] =1 else RF[Rt] = 0
 *
 * @author Igor L Marques
 */  
configuration SltiUBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SltiUBytecodeM;

  	TinyReefBytecode = SltiUBytecodeM.TinyReefBytecode;
}