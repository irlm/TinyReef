/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

#include "StorageVolumes.h"


/**
 * StorageProgramC
 *
 * @author Igor L Marques
 * @data Mar 08, 2010.
 * 
 */ 
configuration StorageProgramC
{
	provides
	{
		interface TinyReefStorage;
	}
}

implementation
{

#if !defined(COMPILE_TOSSIM)	
	
	components MainC;
	components StorageProgramM as StorageConfig;
	components new ConfigStorageC(VOLUME_CONFIGTEST);
	
  	StorageConfig.Config -> ConfigStorageC.ConfigStorage;
  	StorageConfig.Mount  -> ConfigStorageC.Mount;
  	StorageConfig.Boot   -> MainC.Boot;
  	
  	TinyReefStorage = StorageConfig;

#else
	
	components StorageProgramDemoM;
	
	TinyReefStorage = StorageProgramDemoM;	  	
  	
#endif


	
}