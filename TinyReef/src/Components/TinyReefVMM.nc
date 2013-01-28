/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Jul 05, 2010.
 *
 */

module TinyReefVMM
{
	uses
	{
		interface Boot;
		
		command void load(uint8_t version);
	}
}

implementation
{

	event void Boot.booted()
	{
		dbg("TinyReefC", "Initializing VM\n");
		
		call load(0);
	}
	
}