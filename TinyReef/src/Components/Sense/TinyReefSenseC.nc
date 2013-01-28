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
 
#include "TinyReefSense.h"
 
configuration TinyReefSenseC
{
	provides
	{
		interface Read<uint16_t>[uint8_t type];
	}
}

implementation
{
	
#if defined(SENSORBOARD)
	components Mts300C as sensors;
#else
	components DemoSenseAllSupportedC as sensors;
#endif
	
	
	Read = sensors.Read;
}