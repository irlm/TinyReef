/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Apr 26, 2010.
 *
 */
 
/**
 * Component LUI -- Load Upper Immediate
 * lui Rt, Imm # RF[Rt] = Imm<<16 | 0x0000
 *
 * @author Igor L Marques
 */  
configuration LuiBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components LuiBytecodeM;

  	TinyReefBytecode = LuiBytecodeM.TinyReefBytecode;
}