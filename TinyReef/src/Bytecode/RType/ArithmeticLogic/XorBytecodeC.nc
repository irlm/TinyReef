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
 * Component XOR: Exclusive OR:
 * xor Rd, Rs, Rt # RF[Rd] = RF[Rs] XOR RF[Rt]
 *
 * @author Igor L Marques
 */ 
configuration XorBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components XorBytecodeM;
		
  	TinyReefBytecode = XorBytecodeM.TinyReefBytecode;
}