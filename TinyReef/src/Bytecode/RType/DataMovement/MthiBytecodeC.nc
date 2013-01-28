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
 * Component MFHI – Move to High:
 * mthi Rs # HIGH = RF[Rs]
 *
 * @author Igor L Marques
 */ 
configuration MthiBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components MthiBytecodeM;

  	TinyReefBytecode = MthiBytecodeM.TinyReefBytecode;
}