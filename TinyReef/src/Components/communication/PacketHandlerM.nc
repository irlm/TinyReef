
#include "TinyReefMessage.h"

#define TIMEOUT 15000

module PacketHandlerM
{
	provides
	{
		command void ReceivePacket(uint8_t id, tinyReefPacket_t *packet);	
	}
	
	uses
	{
		interface Timer<TMilli> as TimerApplication;
		interface Timer<TMilli> as TimerProgramUpdate;
  		
  		interface TinyReefSend;
  		
  		command void ReceivedData(uint8_t *const data, uint8_t dataLength);
	}
}

implementation
{
	bool applicationNew = TRUE;
					
	bool programUpdateNew = TRUE;
	
	//tinyReefRequestPacket_t requestPacket;
	
	void verifyMessage(uint8_t id, bool *newPacket);		
		
	command void ReceivePacket(uint8_t id, tinyReefPacket_t *const packet)
	{
		bool *newPacket;
		
		dbg("TinyReefCommunication", "PacketHandlerM -> ReceivePacket\n");
		
		newPacket = NULL;
		
		switch(id)
		{
			case AM_TINYREEF_APPLICATION:
				{
					dbg("TinyReefCommunication", "PacketHandlerM -> ReceivePacket -> AM_TINYREEF_APPLICATION\n");
					
					if((packet != NULL) && (1 == packet->head.total_packet))
					{
						call ReceivedData((uint8_t *)packet->data, (uint8_t)packet->head.length);
					}
					else
					{
						//TODO ...
						call TimerApplication.stop();
						dbg("TinyReefCommunication", "PacketHandlerM -> ReceivePacket -> applicationNew = %d\n", applicationNew);
						newPacket = &applicationNew;					
						call TimerApplication.startPeriodic( TIMEOUT );
					
					}
					break;
				}
			
			case AM_TINYREEF_PROGRAM_UPDATE_MESSAGE:
				{
					dbg("TinyReefCommunication", "PacketHandlerM -> ReceivePacket -> AM_TINYREEF_PROGRAM_UPDATE_MESSAGE\n");
					//call TimerProgramUpdate.stop();
					//actualMessage = &programUpdateMessage;
					//dbg("TinyReefC", "PacketHandlerM -> ReceivePacket -> programUpdateNew = %d\n", programUpdateNew);
					//newPacket = &programUpdateNew;					
					//call TimerProgramUpdate.startPeriodic( TIMEOUT );
					break;
				}
			default:
				//empty
				break;				 	
		}
		
		//TODO ver geral...
		/*
		if(actualMessage != NULL)
		{
			dbg("TinyReefCommunication", "ReceivePacket -> actualMessage != NULL\n");
			
			dbg("TinyReefCommunication", "ReceivePacket -> packet->head.version = %d\n", packet->head.version);
			dbg("TinyReefCommunication", "ReceivePacket -> packet->head.packet_number = %d\n", packet->head.packet_number);
			dbg("TinyReefCommunication", "ReceivePacket -> packet->head.total_packet = %d\n", packet->head.total_packet);
			dbg("TinyReefCommunication", "ReceivePacket -> packet->head.requestPacket.head.length = %d\n", packet->head.length);
			
			if(*newPacket)
			{
				//reset
				int i;
				
				dbg("TinyReefCommunication", "ReceivePacket -> newPacket\n");
				
				for(i = 0; i < packet->head.total_packet; i++)
				{
					memcpy(actualMessage->data[i], "\0", (MAX_PACKET_LENGTH * sizeof(uint8_t)));
					actualMessage->received[i] = FALSE;
				}
				
				memcpy(&actualMessage->head, &packet->head, sizeof(tinyReefPacketHead_t));
				dbg("TinyReefCommunication", "ReceivePacket -> actualMessage->head.version = %d\n", packet->head.version);
				dbg("TinyReefCommunication", "ReceivePacket -> actualMessage->head.packet_number = %d\n", actualMessage->head.packet_number);
				dbg("TinyReefCommunication", "ReceivePacket -> actualMessage->head.total_packet = %d\n", actualMessage->head.total_packet);
				dbg("TinyReefCommunication", "ReceivePacket -> actualMessage->head.length = %d\n", actualMessage->head.length);
			}
			
			if(packet->head.version == actualMessage->head.version)
			{
				dbg("TinyReefCommunication", "ReceivePacket -> version == actualMessage->version\n");
				
				dbg("TinyReefCommunication", "ReceivePacket -> packet->head.packet_number = %d\n", packet->head.packet_number);
				
				memcpy(actualMessage->data[packet->head.packet_number - 1], packet->data, MAX_PACKET_LENGTH);
				
				actualMessage->received[packet->head.packet_number-1] = TRUE;				
				
				if(actualMessage->head.total_packet == packet->head.packet_number)
				{
					verifyMessage(id, actualMessage, newPacket);
				}
			}
			else
			{
				//for now just ignore...
				dbg("TinyReefCommunication", "ReceivePacket -> for now just ignore...\n");
			}							
		}
		 */
	}
	
	void verifyMessage(uint8_t id, bool *newPacket)
	{
		//TODO geral...
		/*
		int i;
		bool error = FALSE;
		
		dbg("TinyReefCommunication", "verifyMessage\n");
		dbg("TinyReefCommunication", "verifyMessage -> actualMessage->head.length = %d\n", actualMessage->head.length);
		
		//requestPacket.amType = id;
		//memcpy(&requestPacket.head, &actualMessage->head, sizeof(tinyReefPacketHead_t));
		
		for(i = 0; i < actualMessage->head.total_packet; i++)
		{
			if(FALSE == actualMessage->received[i])
			{
				//request new packet
				error = TRUE;
				dbg("TinyReefCommunication", "verifyMessage -> FALSE == actualMessage->received[%d]\n", i);
			}
			
			//requestPacket.data[i] = actualMessage->received[i];
		}
		
		//TODO ver esse troço.....
		if(TRUE == error)
		{
			dbg("TinyReefCommunication", "verifyMessage -> TRUE == error\n");
			
			//call SendPacket(AM_TINYREEF_REQUEST_MESSAGE, (tinyReefPackets_t*)&requestPacket, AM_BROADCAST_ADDR);	
		}
		else
		{
			dbg("TinyReefCommunication", "verifyMessage -> complete and OK\n");
			
			switch (id) {
				case AM_TINYREEF_APPLICATION:
					call TimerApplication.stop();
					dbg("TinyReefCommunication", "verifyMessage -> call ReceivedData(actualMessage)\n");
					call ReceivedData(actualMessage);
					break;
				case AM_TINYREEF_PROGRAM_UPDATE_MESSAGE:
					
					break;
				case AM_TINYREEF_POLICY_UPDATE_MESSAGE:
					
					break;
					
				default:
					break;
			}
			
	  	 if(AM_TINYREEF_PROGRAM_UPDATEMESSAGE == id){
	  		
	  		tinyReefUpdateMessage_t* message = (tinyReefUpdateMessage_t*) payload;
	  		
	  		if (len != sizeof(tinyReefUpdateMessage_t)) 
	    	{
		    	dbg("TinyReefCommunicationommunication", "Len != sizeof(tinyReefUpdateMessage_t)");
		    	return msg;
		    }else		    		    
		    	call programAssemble(message);
		    	
	  	}else if(AM_TINYREEF_POLICY_UPDATEMESSAGE == id){
	  		tinyReefUpdateMessage_t* message = (tinyReefUpdateMessage_t*) payload;
	  		
	  		if (len != sizeof(tinyReefUpdateMessage_t)) 
	    	{
		    	dbg("TinyReefCommunicationommunication", "Len != sizeof(tinyReefUpdateMessage_t)");
		    	return msg;
		    }else
	  			call policyAssemble(message);
		    
	  	}else if(AM_TINYREEFMESSAGE == id){
			call EventHandler.executeEvent(EV_RECEIVE, (uint8_t)id);
		}		
		}
		*/				
	}
	
	event void TimerApplication.fired(){
		dbg("TinyReefCommunication", "TimerApplication.fired()\n");
		verifyMessage(AM_TINYREEF_APPLICATION, &applicationNew);
	}

	event void TimerProgramUpdate.fired()
	{
		dbg("TinyReefCommunication", "TimerProgramUpdate.fired()\n");
		verifyMessage(AM_TINYREEF_PROGRAM_UPDATE_MESSAGE, &programUpdateNew);
	}

	event void TinyReefSend.SendPacketDone(error_t error){}
}