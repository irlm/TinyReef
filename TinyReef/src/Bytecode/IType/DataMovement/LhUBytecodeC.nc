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
 * Component LHU -- Load Halfword Unsigned
 * lhu Rt, offset(Rs) # RF[Rt] = Mem[RF[Rs] + Offset]
 *
 * @author Igor L Marques
 */  
configuration LhUBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components LhUBytecodeM as Bytecode;
	components TinyReefMemoryAccessM;
	
	Bytecode.Memory -> TinyReefMemoryAccessM.Memory;
  	TinyReefBytecode = Bytecode.TinyReefBytecode;
}