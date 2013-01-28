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
 * Component OR:
 * or Rd, Rs, Rt # RF[Rd] = RF[Rs] OR RF[Rt]
 *
 * @author Igor L Marques
 */ 
configuration OrBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components OrBytecodeM;
		
  	TinyReefBytecode = OrBytecodeM.TinyReefBytecode;
}