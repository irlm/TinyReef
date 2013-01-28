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
 * Component BGEZ -- Branch on greater than or equal to zero
 * bgez Rs, Label # If (RF[Rs] >= RF[0]) then PC = PC + Imm<< 2
 *
 * @author Igor L Marques
 */    
configuration BgezBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components BgezBytecodeM;

  	TinyReefBytecode = BgezBytecodeM.TinyReefBytecode;
}
