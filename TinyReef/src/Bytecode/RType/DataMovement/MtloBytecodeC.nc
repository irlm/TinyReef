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
 * Component MTLO – Move to Low:
 * mtlo Rs # LOW = RF[Rs]
 *
 * @author Igor L Marques
 */ 
configuration MtloBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components MtloBytecodeM;

  	TinyReefBytecode = MtloBytecodeM.TinyReefBytecode;
}