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
 * Component J - Jump and link
 * jal Label # RF[$ra] = PC; PC = PC(31:28) | Imm<< 2
 *
 * @author Igor L Marques
 */   
configuration JalBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components JalBytecodeM;

  	TinyReefBytecode = JalBytecodeM.TinyReefBytecode;
}
