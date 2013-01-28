/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Set 08, 2009.
 *
 */
 
/**
 * Component SUB – Subtract:
 * sub Rd, Rs, Rt # RF[Rd] = RF[Rs] - RF[Rt]
 *
 * @author Igor L Marques
 */ 
configuration SubBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components SubBytecodeM;
	
  	TinyReefBytecode = SubBytecodeM.TinyReefBytecode;
}