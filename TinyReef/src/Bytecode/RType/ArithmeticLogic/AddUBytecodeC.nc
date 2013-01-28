/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Set 23, 2009.
 *
 */
 
/**
 *  ADDU -- Add unsigned (no overflow).
 * addu Rd, Rs, Rt # RF[Rd] = RF[Rs] + RF[Rt]
 *
 * @author Igor L Marques
 */ 
 
configuration AddUBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components AddUBytecodeM;

  	TinyReefBytecode = AddUBytecodeM.TinyReefBytecode;
}