#include "TinyReef.h"

module TinyReefTestMOVBytecodeM
{
	uses
	{
		interface Boot;
		interface TinyReefBytecode as MOV;
		interface TinyReefBytecode as MOVM;
		interface TinyReefBytecode as MOVC;	
	}
}

implementation
{
	
	tinyReefContext_t context;
	
	event void Boot.booted()
	{
		
		// run program boot
		dbg("TinyReefTest", "Start test - MOV...\n");
	    
	    dbg("TinyReefTest", "Start test - MOV\n");
	    context.registerFile[R_T2] = 2000;
	    
	    call MOV.execute(&context, 0x120000);
	    dbg("TinyReefC", "state.registers[1] = %d\n", state.registers[1]);		    
	    
	    dbg("TinyReefTest", "-----------------------------------------------------------------\n");
	    	    
	    dbg("TinyReefTest", "Start test - MOVM\n");
	    
	    /*
	     * R1 - 00000000 00000000 00000000 00000001
	     * R2 - 00000000 00000000 00000101 00000010
	     * R3 - 00000000 00000000 00000000 00000011
	     * 
	     * M  - 00000001 00000101 00000010 00000011
	     * 
	     * mov M R1 3 0
	     * mov M R2 2 1
	     * mov M R3 0 0
	     * 
	     * mov R1 M 0 0
	     * mov R2 M 1 1
	     * mov R3 M 3 0
	     * 
	     */
	    
	    context.registerFile[R_T0] = 1;
	    context.registerFile[R_T1] = 1282;
	    context.registerFile[R_T2] = 3;
	    
	    context.Memory[1] = 0;
	    
	    call MOVM.execute(&context, 0x11C0);
	    dbg("TinyReefC", "state.registers[1] =%d\n", state.registers[1]);		    
	    dbg("TinyReefC", "state.memory[1] =%d\n", state.memory[1]);	
	    
	    call MOVM.execute(&context, 0x1290);
	    dbg("TinyReefC", "state.registers[2] =%d\n", state.registers[2]);		    
	    dbg("TinyReefC", "state.memory[1] =%d\n", state.memory[1]);	
	    
	    call MOVM.execute(&context, 0x1300);
	    dbg("TinyReefC", "state.registers[3] =%d\n", state.registers[3]);		    
	    dbg("TinyReefC", "state.memory[1] =%d\n", state.memory[1]);
	    
	    dbg("TinyReefC", "Result = state.memory[1] =%d\n", state.memory[1]);	
	    
	    dbg("TinyReefTest", "-----------------------------------------------------------------\n");
	    
	    dbg("TinyReefTest", "Start test - MOVC\n");
	    
	    call MOVC.execute(&context, 0x1FFFF0);
	    dbg("TinyReefC", "state.registers[1] = %d\n", state.registers[1]);		    
	    	        
		dbg("TinyReefC", "End test - MOV...\n");		
	}
}