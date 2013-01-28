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
 * Component SH -- Store Halfword:
 * sh Rt, offset(Rs) # Mem[RF[Rs] + Offset] = RF[Rt]
 *
 * @author Igor L Marques
 */  
configuration ShBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components ShBytecodeM as Bytecode;
	components TinyReefMemoryAccessM;
	
	Bytecode.Memory -> TinyReefMemoryAccessM.Memory;
  	TinyReefBytecode = Bytecode.TinyReefBytecode;
}