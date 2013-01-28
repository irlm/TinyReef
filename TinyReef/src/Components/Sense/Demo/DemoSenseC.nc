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

configuration DemoSenseC
{
	provides
	{
		interface Read<uint16_t>;
	}
}

implementation
{
	components DemoSenseM;
	
	components RandomC;

	DemoSenseM.Random -> RandomC;
		
	Read = DemoSenseM;
}