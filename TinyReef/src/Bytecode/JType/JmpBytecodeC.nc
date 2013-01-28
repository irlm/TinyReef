/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Set 16, 2009.
 *
 */

/**
 * Component JMP - Jump
 * jmp Label # PC = PC(31:28) | Imm<< 2
 *
 * @author Igor L Marques
 */   
configuration JmpBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components JmpBytecodeM;
	
  	TinyReefBytecode = JmpBytecodeM.TinyReefBytecode;
}