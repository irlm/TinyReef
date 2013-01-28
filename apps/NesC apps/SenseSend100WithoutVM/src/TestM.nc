 
#include "Timer.h"
#include "Tests.h"

module TestM @safe()
{
	uses
	{
	    interface Leds;
	    interface Boot;
	    interface AMSend;
	    interface Timer<TMilli> as MilliTimer;
	    interface Packet;
	    interface Read<uint16_t>;
	    interface SplitControl as RadioControl;
  	}
}

implementation
{
	message_t packet;
	bool locked = FALSE;
	uint8_t count = 0;
   
  	event void Boot.booted()
  	{
    	call RadioControl.start();
  	}

  	event void RadioControl.startDone(error_t err)
  	{
    	if (SUCCESS == err)
    	{
      		call MilliTimer.startOneShot(250);
    	}
  	}
  	
  	event void RadioControl.stopDone(error_t err) {}
  
  	event void MilliTimer.fired()
  	{
  		call Leds.led0Off();
  		call Read.read();  		
  	}

	event void Read.readDone(error_t result, uint16_t data)
 	{
 		if (locked)
    	{
      		return;
    	}
    	else
    	{
      		test_msg_t* tmsg;

      		tmsg = (test_msg_t*)call Packet.getPayload(&packet, sizeof(test_msg_t));
      		if (tmsg == NULL)
      		{
				return;
      		}
      		
      		tmsg->data = data;
      		if (call AMSend.send(AM_BROADCAST_ADDR, &packet, sizeof(test_msg_t)) == SUCCESS)
      		{
				locked = TRUE;
      		}
    	}
  	}

	event void AMSend.sendDone(message_t* bufPtr, error_t error)
	{
    	if (&packet == bufPtr)
    	{
      		locked = FALSE;
      		
      		count++;
      		call Read.read();
      		
      		if(count >= 100)
      		{
      			count = 0;
      			call Leds.led0On();
      			call MilliTimer.startOneShot(600);	
      		}
    	}
  	}
}
