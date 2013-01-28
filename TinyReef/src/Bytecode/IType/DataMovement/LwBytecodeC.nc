/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   May 03, 2010.
 *
 */
 
/**
 * Component LW -- Load Word:
 * lw Rt, offset(Rs) # RF[Rt] = Mem[RF[Rs] + Offset]
 *
 * @author Igor L Marques
 */  
configuration LwBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components LwBytecodeM as Bytecode;
	components TinyReefMemoryAccessM;
	
	components LedsC;
	Bytecode.Leds -> LedsC;
	
	Bytecode.Memory -> TinyReefMemoryAccessM.Memory;
  	TinyReefBytecode = Bytecode.TinyReefBytecode;
}