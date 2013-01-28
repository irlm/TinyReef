
#include "Tests.h"

configuration TestC
{
}

implementation
{
	components MainC, TestM as App, LedsC, new DemoSensorC();
  	components ActiveMessageC;
  	components new AMSenderC(AM_TEST_MSG);
  	components new TimerMilliC();
  
  	App.Boot -> MainC.Boot;
  
  	App.AMSend -> AMSenderC;
  	App.RadioControl -> ActiveMessageC;
  	App.Leds -> LedsC;
  	App.MilliTimer -> TimerMilliC;
  	App.Packet -> AMSenderC;
  	App.Read -> DemoSensorC;
}
