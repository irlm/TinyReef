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
 * Component LWR -- Load Word Right:
 * lwr Rt, offset(Rs) # RF[Rt] = Mem[RF[Rs] + Offset]t]
 *
 * @author Igor L Marques
 */  
configuration LwrBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components LwrBytecodeM;

  	TinyReefBytecode = LwrBytecodeM.TinyReefBytecode;
}