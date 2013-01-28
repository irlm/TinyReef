/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Jul 16, 2010.
 *
 */
 
#include "TinyReefResource.h"

configuration InterpreterResourceP
{
	provides
	{
		interface Resource[uint8_t id];
		interface ResourceRequested[uint8_t id];
		interface TinyReefInterpreter[uint8_t id];
	}
    uses
    {
    	interface ResourceConfigure[uint8_t id];
    }
}

implementation
{
	components new FcfsArbiterC(UQ_INTERPRETER_RESOURCE) as Arbiter;
  	components new SplitControlPowerManagerC() as PowerManager;
  	
  	components InterpreterC;
  	components InterpreterResourceImplP;
  	
  	
	TinyReefInterpreter = InterpreterResourceImplP.SharedTinyReefInterpreters;
	
	Resource = Arbiter;
	
	ResourceRequested = Arbiter;
	
	ResourceConfigure = Arbiter;
	
	InterpreterResourceImplP.ArbiterInfo -> Arbiter;
	
	PowerManager.ResourceDefaultOwner -> Arbiter;
	PowerManager.SplitControl -> InterpreterC.SplitControl;
	
	InterpreterResourceImplP.TinyReefInterpreter -> InterpreterC.TinyReefInterpreter;
}

