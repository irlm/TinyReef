/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   May 28, 2010.
 *
 */

configuration ExitBytecodeC
{
	provides
	{
		interface TinyReefBytecode;
	}
}

implementation
{
	components ExitBytecodeM;
	
	TinyReefBytecode = ExitBytecodeM;
}