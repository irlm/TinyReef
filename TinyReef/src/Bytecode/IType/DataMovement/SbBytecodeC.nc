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
 * Component SB -- Store Byte:
 * sb Rt, offset(Rs) # Mem[RF[Rs] + Offset] = RF[
 *
 * @author Igor L Marques
 */  
configuration SbBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SbBytecodeM as Bytecode;
	components TinyReefMemoryAccessM;
	
	Bytecode.Memory -> TinyReefMemoryAccessM.Memory;
  	TinyReefBytecode = Bytecode.TinyReefBytecode;
}