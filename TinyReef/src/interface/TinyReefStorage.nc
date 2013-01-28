/*									
 *
 * "Copyright (c) 2009-10 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Fev 21, 2010.
 *
 */
 
 #include "TinyReef.h"

interface TinyReefStorage
{
	command void readProgram(tinyReefContext_t* context, uint8_t version);
	
	command void writeProgram(uint8_t version, uint8_t *memory, uint16_t length);
}