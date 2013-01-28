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
 * 
 * @author Igor L Marques
 */ 
configuration ExtensionBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components ExtensionBytecodeM;
	
//Control Flow Instructions
	components BgezBytecodeC, BgezalBytecodeC,
	 BltzalBytecodeC, BltzBytecodeC;
	
	ExtensionBytecodeM.Codes[ITEX_BGEZ] 	-> BgezBytecodeC;
	ExtensionBytecodeM.Codes[ITEX_BGEZAL] 	-> BgezalBytecodeC;
	ExtensionBytecodeM.Codes[ITEX_BLTZAL] 	-> BltzalBytecodeC;
	ExtensionBytecodeM.Codes[ITEX_BLTZ] 	-> BltzBytecodeC;

  	TinyReefBytecode = ExtensionBytecodeM.TinyReefBytecode;
}