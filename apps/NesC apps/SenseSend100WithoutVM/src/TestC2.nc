
#include "Tests.h"

configuration TestC2
{
}

implementation
{
	components MainC, TestM2 as App, LedsC, new DemoSensorC();
  	components ActiveMessageC;
  	components new AMSenderC(AM_TEST_MSG);
  	components new AMReceiverC(AM_TEST_MSG);
  	components new TimerMilliC();
  	  
  	App.Boot -> MainC.Boot;
  
  	App.Receive -> AMReceiverC;
  	App.AMSend -> AMSenderC;
  	App.RadioControl -> ActiveMessageC;
  	App.Leds -> LedsC;
  	App.MilliTimer -> TimerMilliC;
  	App.Packet -> AMSenderC;
  	App.Read -> DemoSensorC;
}
