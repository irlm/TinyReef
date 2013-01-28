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

module ReceiveM
{
	uses
	{
		interface Boot;
		
		interface SplitControl as RadioControl;
    	
	    interface Receive as RadioReceive[am_id_t id];
	    interface Receive as RadioSnoop[am_id_t id];
	    
	    interface Packet as RadioPacket;
	    interface AMPacket as RadioAMPacket;
	    
	    command void ReceivePacket(uint8_t id, tinyReefPacket_t *packet);
    }
}

implementation
{
	message_t* receive(am_id_t id, message_t* msg, void* payload, uint8_t len);
	
	event void Boot.booted()
	{
		call RadioControl.start();
	}
	
	event void RadioControl.startDone(error_t error)
	{
		if (error == SUCCESS)
		{
			dbg("TinyReefCommunication", "RadioControl.startDone receive == SUCCESS\n");
   	 	}
   	 	else
   	 	{
   	 		dbg("TinyReefCommunication", "RadioControl.startDone receive == FAIL\n");

	    	call RadioControl.start();
   	 	}
  	}
	
  	event void RadioControl.stopDone(error_t error) {}
  
	event message_t *RadioSnoop.receive[am_id_t id](message_t *msg,
						    void *payload,
						    uint8_t len)
	{
		dbg("TinyReefCommunication", "RadioSnoop receive[%d].\n", id);
    	return receive(id, msg, payload, len);
  	}	
  
  	event message_t *RadioReceive.receive[am_id_t id](message_t *msg,
						    void *payload,
						    uint8_t len)
	{
		dbg("TinyReefCommunication", "RadioReceive receive[%d].\n", id);
    	return receive(id, msg, payload, len);
  	}
	
	message_t* receive(am_id_t id, message_t *msg, void *payload, uint8_t len)
	{
		dbg("TinyReefCommunication", "receive[%d].\n", id);
		
		switch (id) {
			case AM_TINYREEF_APPLICATION:
			case AM_TINYREEF_PROGRAM_UPDATE_MESSAGE:
				{
					tinyReefPacket_t* trp = (tinyReefPacket_t*)payload;
			
					call ReceivePacket((uint8_t)id, trp);
				} 
				break;
			default:
				dbg("TinyReefCommunication", "packet id = %d received is not supported.\n");
				break;
		}
		
		return msg;	
  	}
}