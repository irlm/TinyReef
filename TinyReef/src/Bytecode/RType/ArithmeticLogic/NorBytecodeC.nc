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
 * Component NOR:
 * nor Rd, Rs, Rt # RF[Rd] = RF[Rs] NOR RF[Rt]
 *
 * @author Igor L Marques
 */ 
configuration NorBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components NorBytecodeM;
		
  	TinyReefBytecode = NorBytecodeM.TinyReefBytecode;
}