/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques, Jobson Ronan
 * History:   Aug 16, 2009.
 *
 */

#include "TinyReef.h"

interface TinyReefEventHandler
{
	command error_t registerEvent(tinyReefContext_t *const context, uint32_t handlerAddress,
		uint32_t endEventAddress, uint8_t *const id);
	
	command error_t executeEvent(uint8_t eventId);
}