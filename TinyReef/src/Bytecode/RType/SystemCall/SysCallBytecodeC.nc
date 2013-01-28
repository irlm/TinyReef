/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   May 04, 2010.
 *
 */
 
/**
 * Component SYSCALL – System Call: (Used to call system services to perform I/O)
 * syscall
 *
 * @author Igor L Marques
 */ 
configuration SysCallBytecodeC
{
	provides
	{
		interface TinyReefBytecode;
	}
}

implementation
{
	components SysCallBytecodeM;
	
	//default
	components ExitBytecodeC;
	
	//custom
	components ReceiveBytecodeC, SendBytecodeC;
	
	components	SenseBytecodeC, SetLedBytecodeC,
		TimerBytecodeC, ToggleLedBytecodeC,
		SetLedStateBytecodeC;

//default
	SysCallBytecodeM.VMCall[SYSCALL_EXIT]	 		-> ExitBytecodeC;
//custom		
	SysCallBytecodeM.VMCall[SYSCALL_RECEIVE] 		-> ReceiveBytecodeC;
	SysCallBytecodeM.VMCall[SYSCALL_SEND] 			-> SendBytecodeC;
	SysCallBytecodeM.VMCall[SYSCALL_SENSE] 			-> SenseBytecodeC;
	SysCallBytecodeM.VMCall[SYSCALL_SET_LED] 		-> SetLedBytecodeC;
	SysCallBytecodeM.VMCall[SYSCALL_TIMER] 			-> TimerBytecodeC;
	SysCallBytecodeM.VMCall[SYSCALL_TOGGLE_LED] 	-> ToggleLedBytecodeC;
	SysCallBytecodeM.VMCall[SYSCALL_SET_LED_STATE] 	-> SetLedStateBytecodeC;
	
	TinyReefBytecode = SysCallBytecodeM.TinyReefBytecode;
}