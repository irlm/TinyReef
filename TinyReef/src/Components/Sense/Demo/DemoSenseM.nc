/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/**
 * @author Igor L Marques
 * @date:   Mar 22, 2010.
 *
 */
 
module DemoSenseM
{
	provides
	{
		interface Read<uint16_t>;
	}
	
	uses
	{
		interface Random;
	}
}

implementation
{	
	command error_t Read.read()
	{
		uint16_t data = call Random.rand16();
		
		dbg("TinyReefSense", "DemoSenseM Read.read() data = 0x%4X\n", data);
			
		signal Read.readDone(SUCCESS, data);
		
		return 	SUCCESS;
	}
}