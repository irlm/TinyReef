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
 * Component BGEZAL -- Branch on greater than or equal to zero and link
 * bgezal Rs, Label # If( RF[Rs] >= RF[0] )then
 * 							{RF[$ra] = PC;
 * 							 PC = PC + Imm<< 2 }
 *
 * @author Igor L Marques
 */ 
configuration BgezalBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components BgezalBytecodeM;

  	TinyReefBytecode = BgezalBytecodeM.TinyReefBytecode;
}
