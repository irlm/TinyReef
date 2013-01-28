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

#include "TinyReef.h"
#include "TinyReefMessage.h"
#include "AM.h"

configuration InstructionSetFullC 
{
	provides
	{
		interface TinyReefBytecode as Bytecode[uint8_t opcode];
	} 
}

implementation
{
	components RTypeBytecodeC, ExtensionBytecodeC;
	
	//Control Flow Instructions
	components JmpBytecodeC, JalBytecodeC;
	
	//Control Flow Instructions
	components BeqBytecodeC, BneBytecodeC,
	BlezBytecodeC, BgtzBytecodeC;
			
	//Arithmetic and Logic Instructions
	components AddIBytecodeC, AddIUBytecodeC,
	AndIBytecodeC, OrIBytecodeC,
	XorIBytecodeC;
	
	//Data Movement Instructions
	components SltiBytecodeC, SltiUBytecodeC,
	LuiBytecodeC, LbBytecodeC,
	LhBytecodeC, LwlBytecodeC,
	LwBytecodeC, LbUBytecodeC,
	LhUBytecodeC, LwrBytecodeC,
	SbBytecodeC, ShBytecodeC,
	SwlBytecodeC, SwBytecodeC,
	SwrBytecodeC;
	
	Bytecode[OP_R_TYPE]		= RTypeBytecodeC;
	
	Bytecode[OP_I_TYPE_EXT]	= ExtensionBytecodeC;
//Control Flow Instructions	
	Bytecode[OP_JMP]		= JmpBytecodeC;
	Bytecode[OP_JAL]		= JalBytecodeC;
//Control Flow Instructions	
	Bytecode[OP_BEQ]		= BeqBytecodeC;
	Bytecode[OP_BNE]		= BneBytecodeC;
	Bytecode[OP_BLEZ]		= BlezBytecodeC;
	Bytecode[OP_BGTZ]		= BgtzBytecodeC;
//Arithmetic and Logic Instructions
	Bytecode[OP_ADD_I]		= AddIBytecodeC;
	Bytecode[OP_ADD_I_U]	= AddIUBytecodeC;
	Bytecode[OP_AND_I]		= AndIBytecodeC;
	Bytecode[OP_OR_I]		= OrIBytecodeC;
	Bytecode[OP_XOR_I]		= XorIBytecodeC;
//Data Movement Instructions
	Bytecode[OP_SLTI]		= SltiBytecodeC;
	Bytecode[OP_SLTI_U]		= SltiUBytecodeC;
	Bytecode[OP_LUI]		= LuiBytecodeC;
	Bytecode[OP_LB]			= LbBytecodeC;
	Bytecode[OP_LH]			= LhBytecodeC;
	Bytecode[OP_LWL]		= LwlBytecodeC;
	Bytecode[OP_LW]			= LwBytecodeC;
	Bytecode[OP_LB_U]		= LbUBytecodeC;
	Bytecode[OP_LH_U]		= LhUBytecodeC;
	Bytecode[OP_LWR]		= LwrBytecodeC;
	Bytecode[OP_SB]			= SbBytecodeC;
	Bytecode[OP_SH]			= ShBytecodeC;
	Bytecode[OP_SWL]		= SwlBytecodeC;
	Bytecode[OP_SW]			= SwBytecodeC;
	Bytecode[OP_SWR]		= SwrBytecodeC;
	
}