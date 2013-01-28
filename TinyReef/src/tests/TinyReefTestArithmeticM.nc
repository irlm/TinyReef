/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Set 08, 2009.
 *
 */
 
#include "TinyReef.h"

module TinyReefTestArithmeticM
{
	uses
	{
		interface Boot;
			
		interface TinyReefBytecode as ADD;
    	interface TinyReefBytecode as ADD_CONST;
    	interface TinyReefBytecode as ADD_U    ;
	    interface TinyReefBytecode as ADD_CONST_U;
    	interface TinyReefBytecode as AND;
	    interface TinyReefBytecode as AND_CONST;
	    interface TinyReefBytecode as DIV;
	    interface TinyReefBytecode as DIVU;
	    interface TinyReefBytecode as MULT;
	    interface TinyReefBytecode as MULTU;
	    interface TinyReefBytecode as OR;
	    interface TinyReefBytecode as OR_CONST;
	    interface TinyReefBytecode as SLL;
	    interface TinyReefBytecode as SLLV;
	    interface TinyReefBytecode as SRL;
	    interface TinyReefBytecode as SRLV;
        interface TinyReefBytecode as SUB;
	    interface TinyReefBytecode as SUBU;
    	interface TinyReefBytecode as XOR;
    	interface TinyReefBytecode as XOR_CONST;
	}
}

implementation
{
	tinyReefContext_t context;
	
	event void Boot.booted()
	{
		// run program boot
		dbg("TinyReefTest", "Start test - Arithmetic...\n");
	    
	  	context.registerFile[R_T0] = 0;
	  	context.registerFile[R_T1] = 3;
	  	context.registerFile[R_T2] = 4;
	    
	    //const = 4080	    
	    
	    call ADD.execute(&context, 0xFF123FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be 7)\n", context.registerFile[R_T0]);
	    
	    call ADD_CONST.execute(&context, 0xFF120FF0);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be 4083)\n", context.registerFile[R_T0]);			    
		
		context.registerFile[R_T1] = 0x40000000;
		context.registerFile[R_T2] = 0x40000000;
		
		//overflow
		call ADD.execute(&context, 0xFF123FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be -2147483648)\n", context.registerFile[R_T0]);
	    
	    context.registerFile[R_T1] = 0x7FFF0001;
	    
	    //overflow (constant)
	    call ADD_CONST.execute(&context, 0xFF12FFFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be 2147418112)\n", context.registerFile[R_T0]);
	    
	    context.registerFile[R_T1] = 0x7FFF8001;
	    
	    //overflow
	    call ADD_CONST.execute(&context, 0xFF127FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be -2147483648)\n", context.registerFile[R_T0]);			
		
		context.registerFile[R_T1] = 3;
	    context.registerFile[R_T2] = 4;
		
		call ADD_U.execute(&context, 0xFF123FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %u (should be 7)\n", context.registerFile[R_T0]);
	    
	    call ADD_CONST_U.execute(&context, 0xFF120FF0);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %u (should be 4083)\n", context.registerFile[R_T0]);
	    
	    context.registerFile[R_T1] = 0x40000000;
		context.registerFile[R_T2] = 0x40000000;
		
		call ADD_U.execute(&context, 0xFF123FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %u (should be 2147483648)\n", context.registerFile[R_T0]);
	    
	    context.registerFile[R_T1] = 0x7FFF0001;
	    
	    call ADD_CONST_U.execute(&context, 0xFF12FFFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %u (should be 2147483648)\n", context.registerFile[R_T0]);
	    
	    context.registerFile[R_T1] = 0x7FFF8001;
	    
	    call ADD_CONST_U.execute(&context, 0xFF127FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %u (should be 2147483648)\n", context.registerFile[R_T0]);
	    
	    call AND.execute(&context, 0xFF123FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %u (should be 1073741824)\n", context.registerFile[R_T0]);
	    
	    call AND.execute(&context, 0xFF122FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %u (should be 2147450881)\n", context.registerFile[R_T0]);
	    
	    call AND_CONST.execute(&context, 0xFF120FF0);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %u (should be 0)\n", context.registerFile[R_T0]);
	    
	    context.registerFile[R_T1] = 8;
	    
	    call DIV.execute(&context, 0xFF123FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be 2)\n", context.registerFile[R_T0]);
	    
	    call DIVU.execute(&context, 0xFF123FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %u (should be 2)\n", context.registerFile[R_T0]);
	    
	    call MULT.execute(&context, 0xFF123FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be 32)\n", context.registerFile[R_T0]);
	    	    
	    call MULTU.execute(&context, 0xFF123FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %u (should be 32)\n", context.registerFile[R_T0]);
	    
	    call OR.execute(&context, 0xFF123FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be 12)\n", context.registerFile[R_T0]);
	    
	    call OR_CONST.execute(&context, 0xFF120FF0);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be 4088)\n", context.registerFile[R_T0]);
	    
	    call SLL.execute(&context, 0xFF120001);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be 16)\n", context.registerFile[R_T0]);
	    
	    call SLLV.execute(&context, 0xFF123FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be 128)\n", context.registerFile[R_T0]);
	    
	    call SRL.execute(&context, 0xFF120001);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be 4)\n", context.registerFile[R_T0]);
	    
	    context.registerFile[R_T1] = 32;
	    
	    call SRLV.execute(&context, 0xFF123FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be 2)\n", context.registerFile[R_T0]);
	    
	    context.registerFile[R_T1] = 3;
	    
	    call SUB.execute(&context, 0xFF123FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be -1)\n", context.registerFile[R_T0]);
	    
	    call SUBU.execute(&context, 0xFF120FF0);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %u (should be -4077)\n", context.registerFile[R_T0]);
	    
	    context.registerFile[R_T1] = 8;
	    
	    call XOR.execute(&context, 0xFF123FFF);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be 12)\n", context.registerFile[R_T0]);
	    
	    call XOR_CONST.execute(&context, 0xFF120FF0);
	    dbg("TinyReefTest", "context.registerFile[R_T0] = %d (should be 4088)\n", context.registerFile[R_T0]);	
	    				   
	    	    
		dbg("TinyReefTest", "End test - Arithmetic.\n");		
	}
}