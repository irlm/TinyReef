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
 * Component MFHI – Move From High:
 * mfhi Rd # RF[Rd] = HIGH
 *
 * @author Igor L Marques
 */ 
configuration MfhiBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components MfhiBytecodeM;

  	TinyReefBytecode = MfhiBytecodeM.TinyReefBytecode;
}