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
 * Component SWR -- Store Word Right:
 * swr Rt, offset(Rs) # Mem[RF[Rs] + Offset] = RF[Rt]
 *
 * @author Igor L Marques
 */  
configuration SwrBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SwrBytecodeM;

  	TinyReefBytecode = SwrBytecodeM.TinyReefBytecode;
}