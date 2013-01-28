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
 * Component DIVU -- Divide unsigned
 * divu Rs, Rt 	# Low = Quotient ( RF[Rs] / RF[Rt] )
 * 				# High = Remainder ( RF[Rs] / RF[Rt] )
 *
 * @author Igor L Marques
 */  
configuration DivUBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components DivUBytecodeM;

  	TinyReefBytecode = DivUBytecodeM.TinyReefBytecode;
}