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

configuration Mts300C
{
	provides
	{
		interface Read<uint16_t>[uint8_t type];
	}
}

implementation
{
	components new DemoSensorC() as sensor;

	Read[VOLTAGE] = sensor.Read;
	
#if defined(SENSORBOARD)
	
	components new TempC() as temperature;
	
	Read[AMBIENT_LIGHT] = Photo.Read;
#endif  
    
  	
  
}
