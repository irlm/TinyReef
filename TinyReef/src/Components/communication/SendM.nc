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
 
 #include "TinyReefMessage.h"
 #include "TinyReefProcessState.h"
 
module SendM
{
	provides
	{
		interface TinyReefSend;
	}
	uses
	{
		interface Boot;
		
    	interface SplitControl as RadioControl;
    	
	    interface AMSend as RadioSend[am_id_t id];
	    interface Packet;
	    interface AMPacket as RadioAMPacket;
	}
}

implementation
{
	bool lock;	
	message_t tinyosPacket;
			
	event void Boot.booted()
	{
		lock = FALSE;
		call RadioControl.start();
	}
	
	command error_t TinyReefSend.SendPacket(am_id_t id, uint16_t DestinationAddress,
		tinyReefPacketHead_t const*const tinyReefPacketHead,
		uint8_t const*const data, uint8_t dataLength)
	{
		error_t ret = FAIL;
		
		dbg("TinyReefCommunication", "SendM - SendPacket\n");
		
		if(TRUE == lock)
			return FAIL;
			
		if(tinyReefPacketHead == NULL)
			return FAIL;
			
		if(data == NULL)
			return FAIL;			
		
		{//workaround
		//to compare the correct value before send the packet
		uint16_t tinyosPacketDataLength = (sizeof(tinyReefPacketHead_t)) + dataLength;
		
		if(tinyosPacketDataLength >= MAX_PACKET_LENGTH)
			return FAIL;
			
		//all ok...	
		{//workaround
		tinyReefPacket_t* tinyReefPacket = (tinyReefPacket_t*) call Packet.getPayload(&tinyosPacket, (uint8_t)(tinyosPacketDataLength));
			
		if(tinyReefPacket != NULL)
		{
			//copy the tinyReefHead...
			if(NULL != memcpy(&tinyReefPacket->head, tinyReefPacketHead, sizeof(tinyReefPacketHead_t)))
			{
				dbg("TinyReefCommunication", "TinyReefSend.SendPacket - tinyReefPacket->head.version = %d\n", (tinyReefPacket->head).version);
				dbg("TinyReefCommunication", "TinyReefSend.SendPacket - tinyReefPacket->head.packet_number = %d\n", (tinyReefPacket->head).packet_number);
				dbg("TinyReefCommunication", "TinyReefSend.SendPacket - tinyReefPacket->head.total_packet = %d\n", (tinyReefPacket->head).total_packet);
				dbg("TinyReefCommunication", "TinyReefSend.SendPacket - tinyReefPacket->head.length = %d\n", (tinyReefPacket->head).length);
				
				//copy the data...
				if(NULL != memcpy(tinyReefPacket->data, data, dataLength))
				{
					
					ret = call RadioSend.send[id](DestinationAddress, &tinyosPacket, (uint8_t)tinyosPacketDataLength);
			
			      	if (SUCCESS == ret)
			      	{
			      		dbg("TinyReefCommunication", "TinyReefSend.SendPacket call send[%d] == SUCCESS\n", id);
			      		lock = TRUE;	
			     	}
			     	else
			     	{
			     		dbg("TinyReefCommunication", "RadioSend.send == FAIL\n");
			     	}		
				}
				else
				{
					dbg("TinyReefCommunication", "TinyReefSend.SendPacket - memcpy from data -> FAIL\n");
					ret = FAIL;
				}
			}
			else
			{
				dbg("TinyReefCommunication", "TinyReefSend.SendPacket - memcpy from tinyReefPacketHead -> FAIL\n");
				ret = FAIL;
			}
		}
		else
		{
			dbg("TinyReefCommunication", "TinyReefSend.SendPacket - tinyReefPacket == NULL -> FAIL\n");
			ret = FAIL;	
		}
		}
		}
		
		return ret;
     }	
    
	event void RadioControl.startDone(error_t error)
	{
		if (SUCCESS == error)
		{
			dbg("TinyReefCommunication", "RadioControl.startDone send == SUCCESS\n");
   	 	}
   	 	else
   	 	{
   	 		dbg("TinyReefCommunication", "RadioControl.startDone send == FAIL\n");
   	 	}	
	}

	event void RadioControl.stopDone(error_t error)
	{
		if (SUCCESS == error)
		{
			dbg("TinyReefCommunication", "RadioControl.stopDone == SUCCESS\n");
   	 	}
   	 	else
   	 	{
   	 		dbg("TinyReefCommunication", "RadioControl.stopDone == FAIL\n");
   	 	}	
	}

	event void RadioSend.sendDone[am_id_t id](message_t *msg, error_t error)
	{
		if (SUCCESS == error)
		{
    		dbg("TinyReefCommunication", "RadioSend.sendDone[%d] == SUCCESS\n", id);	
    	}
    	else
    	{
    		dbg("TinyReefCommunication", "RadioSend.sendDone == FAIL\n");
	  	}
	  	
	  	lock = FALSE;
	  	
	  	signal TinyReefSend.SendPacketDone(error);	
	}
	
	default command error_t RadioSend.send[am_id_t id](am_addr_t addr, message_t* msg,
					  uint8_t len)
	{
		dbg("TinyReefBytecode", "Invalid timer: [%d].\n", id);
		
		return FAIL;
	}
}