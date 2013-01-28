/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Apr 26, 2010.
 *
 */
 
/**
 * Component JALR – jump and Link Register
 * jalr Rd, Rs # RF[Rd] = PC; PC = RF[Rs]
 *
 * @author Igor L Marques
 */ 
configuration JalrBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components JalrBytecodeM;

  	TinyReefBytecode = JalrBytecodeM.TinyReefBytecode;
}