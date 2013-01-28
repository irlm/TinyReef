/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

#include "StorageVolumes.h"

#include <Timer.h>

/**
 * StorageConfigM
 *
 * @author Igor L Marques
 * @data Mar 08, 2010.
 * 
 */ 
module StorageProgramM
{
	uses
	{
		interface Boot;
		interface ConfigStorage;
		interface Mount as ConfigMount;
    }
    provides
	{
		interface TinyReefStorage;
	}
	
}

implementation
{
	void done();
  

	command void TinyReefStorage.readProgram(tinyReefContext_t *context, uint8_t version)
	{
		dbg("TinyReefStorage", "TinyReefStorage.readProgram version = %d.\n", version);
	}

	command void TinyReefStorage.writeProgram(uint8_t version, uint8_t *memory, uint16_t length)
	{
		dbg("TinyReefStorage", "TinyReefStorage.writeProgram version = %d.\n", version);
	}

	event void Boot.booted()
	{
		call ConfigMount.mount();
  	}

	event void ConfigMount.mountDone(error_t error)
	{
		if (SUCCESS == error)
		{
			dbg("TinyReefStorage", "TinyReefStorage ConfigMount.mountDone SUCCESS.\n", version);
		}
		else
		{
			dbg("TinyReefStorage", "TinyReefStorage ConfigMount.mountDone FAIL.\n", version);    
		}
	}
}
