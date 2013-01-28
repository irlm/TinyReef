/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Nov 16, 2009.
 *
 */

#include "AM.h"
#include "Serial.h"

#include "TinyReefMessage.h"

configuration CommunicationC
{
	provides
	{
		interface TinyReefSend;
	}
}

implementation
{
	components MainC;	
	components ActiveMessageC as Radio;
	components new TimerMilliC() as TimerApplication;
  	//components new TimerMilliC() as TimerProgramUpdate;
  	//components new TimerMilliC() as TimerPolicyUpdate;
	
	components PacketHandlerM as packetHandler; 
	
	components ReceiveM as receive;
	components SendM	as send;
	
	components TinyReefMemoryAccessM;
	
	send.Boot -> MainC;
	send.RadioControl -> Radio;
	
	send.RadioSend[AM_TINYREEF_APPLICATION] -> Radio.AMSend[AM_TINYREEF_APPLICATION];
	send.RadioSend[AM_TINYREEF_PROGRAM_UPDATE_MESSAGE] -> Radio.AMSend[AM_TINYREEF_PROGRAM_UPDATE_MESSAGE];
	
	send.Packet -> Radio.Packet;
	send.RadioAMPacket -> Radio.AMPacket;
	
	packetHandler.TimerApplication -> TimerApplication;
	//packetHandler.TimerProgramUpdate -> TimerProgramUpdate;
	//packetHandler.TimerPolicyUpdate -> TimerPolicyUpdate;
	
	packetHandler.TinyReefSend -> send.TinyReefSend;
	
	receive.Boot -> MainC;
	receive.RadioControl -> Radio;
	
	receive.RadioReceive[AM_TINYREEF_APPLICATION] -> Radio.Receive[AM_TINYREEF_APPLICATION];
	//receive.RadioReceive[AM_TINYREEF_PROGRAM_UPDATE_MESSAGE] -> Radio.Receive[AM_TINYREEF_PROGRAM_UPDATE_MESSAGE];
	
	receive.RadioSnoop[AM_TINYREEF_APPLICATION] -> Radio.Snoop[AM_TINYREEF_APPLICATION];
	//receive.RadioSnoop[AM_TINYREEF_PROGRAM_UPDATE_MESSAGE] -> Radio.Snoop[AM_TINYREEF_PROGRAM_UPDATE_MESSAGE];
	
	receive.RadioPacket -> Radio;
	receive.RadioAMPacket -> Radio;
	
	receive.ReceivePacket -> packetHandler.ReceivePacket;

	components ReceiveBytecodeC;	
	packetHandler.ReceivedData -> ReceiveBytecodeC.ReceivedData;
	
	TinyReefSend = send.TinyReefSend;			
}