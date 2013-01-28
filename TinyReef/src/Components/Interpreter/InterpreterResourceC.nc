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

generic configuration InterpreterResourceC()
{
	provides
	{
		interface Resource;
		interface ResourceRequested;
		interface TinyReefInterpreter;
	}
    uses
    {
    	interface ResourceConfigure;
    }
}

implementation
{
	components InterpreterResourceP;

	enum
	{
		RESOURCE_ID = unique(UQ_INTERPRETER_RESOURCE)
	};

  	Resource = InterpreterResourceP.Resource[(unsigned char)RESOURCE_ID];
  	
  	ResourceRequested = InterpreterResourceP.ResourceRequested[(unsigned char)RESOURCE_ID];
  	TinyReefInterpreter = InterpreterResourceP.TinyReefInterpreter[(unsigned char)RESOURCE_ID];
  	ResourceConfigure = InterpreterResourceP.ResourceConfigure[(unsigned char)RESOURCE_ID];
}

