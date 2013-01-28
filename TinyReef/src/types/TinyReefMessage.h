/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/**
 * TinyReef.h
 *
 * @author Igor L Marques
 * @data Jan 28, 2009.
 * 
 */

#ifndef TINY_REEF_MESSAGE_H
#define TINY_REEF_MESSAGE_H

#ifndef TOSH_DATA_LENGTH
	#if defined(PLATFORM_MICA2)
		#define TOSH_DATA_LENGTH  23
	#endif
#endif 



#include "AM.h"
#include "Serial.h"

#include "message.h"

typedef nx_struct tinyReefPacketHead
{
	nx_uint8_t version;
	nx_uint8_t packet_number;
	nx_uint8_t total_packet;
	nx_uint8_t length;
}tinyReefPacketHead_t;

enum{
	MAX_PACKET_LENGTH	= TOSH_DATA_LENGTH - sizeof(tinyReefPacketHead_t) - 1,
	MAX_MESSAGE_LENGTH	= 30,
	MAX_MESSAGE_TYPES	= 3,
	MAX_APPLICATION_DATA_LENGTH	= 16
};

typedef nx_struct tinyReefPacket
{
	tinyReefPacketHead_t head;
    nx_uint8_t data[MAX_PACKET_LENGTH];
}tinyReefPacket_t;

typedef nx_struct tinyReefRequestPacket
{
	tinyReefPacketHead_t head;
	nx_uint8_t amType;
	nx_uint8_t data[MAX_PACKET_LENGTH];		
}tinyReefRequestPacket_t;

/*
typedef nx_struct tinyReefPacket
{
	nx_uint16_t head;
	nx_uint8_t length;
  	nx_int8_t data[MAX_PACKET_LENGTH];
}tinyReefPacket_t;

typedef nx_struct tinyReefRequestPacket 
{	
	nx_uint8_t amType;
	nx_uint8_t version;
	nx_uint8_t data[MAX_MESSAGE_LENGTH];
} tinyReefRequestPacket_t;

typedef nx_struct tinyReefApplicationPacket
{
	nx_uint8_t data[MAX_APPLICATION_DATA_LENGTH];
} tinyReefApplicationPacket_t;

typedef nx_union tinyReefPackets
{
	tinyReefPacket_t vmPacket;
	tinyReefRequestPacket_t requestPacket;
	tinyReefApplicationPacket_t applicationPacket;
} tinyReefPackets_t;
*/

enum
{
  AM_TINYREEF_APPLICATION = 6,
  AM_TINYREEF_PROGRAM_UPDATE_MESSAGE = 9, 
  AM_TINYREEF_POLICY_UPDATE_MESSAGE = 11,
  AM_TINYREEF_REQUEST_MESSAGE = 13  
};

#endif  TINY_REEF_MESSAGE_H
