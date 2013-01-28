/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Jul 16, 2010.
 *
 */

#include "TinyReef.h"

interface TinyReefInterpreter
{
	command error_t interpreterProgram(tinyReefContext_t *const context);
	
	event void interpreterProgramDone(error_t error);
}
