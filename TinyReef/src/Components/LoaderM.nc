#include "TinyReef.h"
#include "TinyReefMessage.h"
#include "Timer.h"

/**
 * bla bla bla
 *
 * @author Igor L Marques
 * @author Jobson Ronan
 */

#include "TinyReefProcessState.h"
 
module LoaderM
{
	provides
	{		
		command void load(uint8_t version);	
	}
	uses
	{
		interface TinyReefStorage as persistence;
		interface Resource;
		interface TinyReefInterpreter;
		
#if defined(COMPILE_WITH_TEST)	
		interface Timer<TMilli> as Timer0;
  		interface Leds;
#endif		 
	}
	
}

implementation
{
	
	tinyReefContext_t context;
	
	/**
   * bla bla bla
   * @param program bla bla bla
   * @param length bla bla bla
   */
	command void load(uint8_t version)
	{	
		dbg("TinyReefC", "Load program version = %d\n", version);
		context.registerFile[R_ZERO] = 0x00000000;

		context.PC = 0;
		context.state = NEW;

		dbg("TinyReefC", "Reading program...\n");	  			
		call persistence.readProgram(&context, version);
		
		context.registerFile[R_SP] = TINYREEF_PROGRAM_SEG_SIZE + context.Offset;
		
		dbg("TinyReefC", "Read program...\n");

		call Resource.request();
	}

#if defined(COMPILE_WITH_TEST)   
    event void Timer0.fired()
  	{
  		context.PC = 0;
  		context.state = NEW;
    	dbg("TinyReefC", "Test the interpreting program...\n");
		call Resource.request();
	 	call Leds.led0Toggle();
  	}
#endif

	event void Resource.granted()
	{
		dbg("TinyReefC", "Interpreting program...\n");
		
		call TinyReefInterpreter.interpreterProgram(&context);

		call Resource.release();
	}
	
	event void TinyReefInterpreter.interpreterProgramDone(error_t error)
	{
		if((FAIL == error) && (BLOCKED == context.state))
		{
			dbg("TinyReefC", "Interpreted program BLOCKED\n");
		}
		else
		{
			dbg("TinyReefC", "Interpreted program with exit = %s\n", error == SUCCESS ? "SUCCESS" : "FAIL");
		}
				
		call Resource.release();
		
#if defined(COMPILE_WITH_TEST)
		call Timer0.startOneShot(500);
#endif
	}
}