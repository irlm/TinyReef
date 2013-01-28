/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Apr 24, 2010.
 *
 */
 
 /**
 * all R-type instructions use opcode 000000. 
 * 
 * @author Igor L Marques
 */ 
configuration RTypeBytecodeC
{
	provides
	{
		interface TinyReefBytecode;
	} 
}

implementation
{
	components RTypeBytecodeM;
	
//Arithmetic and Logic Instructions
	components SllBytecodeC, SrlBytecodeC,
	SraBytecodeC, SllvBytecodeC,
	SrlvBytecodeC, SravBytecodeC;
	
	RTypeBytecodeM.Functions[RT_SLL] 	-> SllBytecodeC;
	RTypeBytecodeM.Functions[RT_SRL] 	-> SrlBytecodeC;
	RTypeBytecodeM.Functions[RT_SRA] 	-> SraBytecodeC;
	RTypeBytecodeM.Functions[RT_SLLV] 	-> SllvBytecodeC;
	RTypeBytecodeM.Functions[RT_SRLV] 	-> SrlvBytecodeC;
	RTypeBytecodeM.Functions[RT_SRAV] 	-> SravBytecodeC;
	
//Control Flow Instructions
	components JmprBytecodeC, JalrBytecodeC;
	
	RTypeBytecodeM.Functions[RT_JMP_R] 	-> JmprBytecodeC;
	RTypeBytecodeM.Functions[RT_JAL_R] 	-> JalrBytecodeC;		

//syscall
	components SysCallBytecodeC;
		
	RTypeBytecodeM.Functions[RT_SYSCALL] -> SysCallBytecodeC;

//Data Movement Instructions
	components MfhiBytecodeC, MthiBytecodeC,
		MfloBytecodeC, MtloBytecodeC;
	
	RTypeBytecodeM.Functions[RT_MFHI] 	-> MfhiBytecodeC;
	RTypeBytecodeM.Functions[RT_MTHI] 	-> MthiBytecodeC;
	RTypeBytecodeM.Functions[RT_MFLO] 	-> MfloBytecodeC;
	RTypeBytecodeM.Functions[RT_MTLO] 	-> MtloBytecodeC;
	
//Arithmetic and Logic Instructions
	components MultBytecodeC, MultUBytecodeC,
	 DivBytecodeC, DivUBytecodeC,
	 AddBytecodeC, AddUBytecodeC,
	 SubBytecodeC, SubUBytecodeC,
	 AndBytecodeC, OrBytecodeC,
	 XorBytecodeC, NorBytecodeC;
	
	RTypeBytecodeM.Functions[RT_MULT]	-> MultBytecodeC;
	RTypeBytecodeM.Functions[RT_MULT_U]	-> MultUBytecodeC;
	RTypeBytecodeM.Functions[RT_DIV]	-> DivBytecodeC;
	RTypeBytecodeM.Functions[RT_DIV_U]	-> DivUBytecodeC;
	RTypeBytecodeM.Functions[RT_ADD] 	-> AddBytecodeC;
	RTypeBytecodeM.Functions[RT_ADD_U] 	-> AddUBytecodeC;
	RTypeBytecodeM.Functions[RT_SUB] 	-> SubBytecodeC;
	RTypeBytecodeM.Functions[RT_SUB_U]	-> SubUBytecodeC;
	RTypeBytecodeM.Functions[RT_AND]	-> AndBytecodeC;
	RTypeBytecodeM.Functions[RT_OR]		-> OrBytecodeC;
	RTypeBytecodeM.Functions[RT_XOR]	-> XorBytecodeC;
	RTypeBytecodeM.Functions[RT_NOR] 	-> NorBytecodeC;


//Data Movement Instructions
	components SltBytecodeC, SltUBytecodeC;
	
	RTypeBytecodeM.Functions[RT_SLT]	-> SltBytecodeC;
	RTypeBytecodeM.Functions[RT_SLT_U]	-> SltUBytecodeC;
	

  	TinyReefBytecode = RTypeBytecodeM.TinyReefBytecode;
}