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
 * Component MULT -- Multiply:
 * mult Rs, Rt # High |Low = RF[Rs] * RF[Rt]
 *
 * @author Igor L Marques
 */  
configuration MultBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components MultBytecodeM;

  	TinyReefBytecode = MultBytecodeM.TinyReefBytecode;
}