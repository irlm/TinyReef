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
 * Component LWL -- Load Word Left:
 * lwl Rt, offset(Rs) # RF[Rt] = Mem[RF[Rs] + Offset]
 *
 * @author Igor L Marques
 */  
configuration LwlBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components LwlBytecodeM;

  	TinyReefBytecode = LwlBytecodeM.TinyReefBytecode;
}