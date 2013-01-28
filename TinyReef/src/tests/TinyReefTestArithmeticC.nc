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
 
configuration TinyReefTestArithmeticC
{
}

implementation
{
	components MainC, TinyReefTestArithmeticM;
	
	//Arithmetic and Logic Instructions
	components AddBytecodeC, AddIBytecodeC,
	 AddUBytecodeC, AddIUBytecodeC,
	 AndBytecodeC, AndIBytecodeC,
	 DivBytecodeC, DivUBytecodeC,
	 MultBytecodeC, MultUBytecodeC,
	 OrBytecodeC, OrIBytecodeC,
	 SllBytecodeC, SllvBytecodeC,
	 SrlBytecodeC, SrlvBytecodeC,
	 SubBytecodeC, SubUBytecodeC,
	 XorBytecodeC, XorIBytecodeC;
	
	TinyReefTestArithmeticM.ADD 			-> AddBytecodeC;
	TinyReefTestArithmeticM.ADD_CONST 		-> AddIBytecodeC;
	TinyReefTestArithmeticM.ADD_U 			-> AddUBytecodeC;
	TinyReefTestArithmeticM.ADD_CONST_U 	-> AddIUBytecodeC;
	TinyReefTestArithmeticM.AND 			-> AndBytecodeC;
	TinyReefTestArithmeticM.AND_CONST	 	-> AndIBytecodeC;
	TinyReefTestArithmeticM.DIV				-> DivBytecodeC;
	TinyReefTestArithmeticM.DIVU			-> DivUBytecodeC;
	TinyReefTestArithmeticM.MULT			-> MultBytecodeC;
	TinyReefTestArithmeticM.MULTU			-> MultUBytecodeC;
	TinyReefTestArithmeticM.OR				-> OrBytecodeC;
	TinyReefTestArithmeticM.OR_CONST		-> OrIBytecodeC;
	TinyReefTestArithmeticM.SLL				-> SllBytecodeC;
	TinyReefTestArithmeticM.SLLV			-> SllvBytecodeC;
	TinyReefTestArithmeticM.SRL				-> SrlBytecodeC;
	TinyReefTestArithmeticM.SRLV			-> SrlvBytecodeC;
	TinyReefTestArithmeticM.SUB 			-> SubBytecodeC;
	TinyReefTestArithmeticM.SUBU	 		-> SubUBytecodeC;
	TinyReefTestArithmeticM.XOR				-> XorBytecodeC;
	TinyReefTestArithmeticM.XOR_CONST		-> XorIBytecodeC;
	
	TinyReefTestArithmeticM.Boot  -> MainC;
}