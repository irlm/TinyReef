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
 * Component SWL -- Store Word Left:
 * swl Rt, offset(Rs) # Mem[RF[Rs] + Offset] = RF[Rt]
 *
 * @author Igor L Marques
 */  
configuration SwlBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SwlBytecodeM;

  	TinyReefBytecode = SwlBytecodeM.TinyReefBytecode;
}