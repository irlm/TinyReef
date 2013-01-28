/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Jul 21, 2010.
 *
 */

#include "TinyReefMessage.h"

interface TinyReefSend
{
	command error_t SendPacket(am_id_t id, uint16_t DestinationAddress,
		tinyReefPacketHead_t const*const tinyReefPacketHead,
		uint8_t const*const data, uint8_t dataLength);
	
	event void SendPacketDone(error_t error);
}
