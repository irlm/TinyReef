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
 
configuration DemoSenseAllSupportedC
{
	provides
	{
		interface Read<uint16_t>[uint8_t type];	
	}
}

implementation
{
	components DemoSenseC as Temperature;
	components DemoSenseC as Humidity;
	components DemoSenseC as Barometric_Pressure;
	components DemoSenseC as Ambient_Light;
	components DemoSenseC as X_Axis_Accelerometer;
	components DemoSenseC as Y_Axis_Accelerometer;
	components DemoSenseC as Gps;
	
	components new DemoSensorC() as Voltage;
	
	Read[TEMPERATURE] = Temperature.Read;
	Read[HUMIDITY] = Humidity.Read;
	Read[BAROMETRIC_PRESSURE] = Barometric_Pressure.Read;
	Read[AMBIENT_LIGHT] = Ambient_Light.Read;
	Read[X_AXIS_ACCELEROMETER] = X_Axis_Accelerometer.Read;
	Read[Y_AXIS_ACCELEROMETER] = Y_Axis_Accelerometer.Read;
	Read[GPS] = Gps.Read;
	
	Read[VOLTAGE] = Voltage.Read;
	
}