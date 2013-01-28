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
 * Component MFLO – Move From Low:
 * mflo Rd # RF[Rd] = LOW
 *
 * @author Igor L Marques
 */ 
configuration MfloBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components MfloBytecodeM;

  	TinyReefBytecode = MfloBytecodeM.TinyReefBytecode;
}