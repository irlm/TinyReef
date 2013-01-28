/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Set 15, 2009.
 *
 */

#include "TinyReefMessage.h"

configuration ReceiveBytecodeC
{
	provides
	{
		interface TinyReefBytecode;
		command void ReceivedData(uint8_t *const data, uint8_t dataLength);
	}
}

implementation
{
	components ReceiveBytecodeM;

	components CommunicationC, EventHandlerC;
		
	ReceiveBytecodeM.EventHandler -> EventHandlerC.EventHandler;	
	
	ReceivedData = ReceiveBytecodeM.ReceivedData;
	
	TinyReefBytecode = ReceiveBytecodeM;
}