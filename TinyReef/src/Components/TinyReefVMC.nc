/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Set 16, 2009.
 *
 */

configuration TinyReefVMC
{
}

implementation
{
	components MainC;
	
	//tinyreef components
	components TinyReefVMM as vm;
	
	//components CommunicationC;
	
	components LoaderC;
	
	vm.load -> LoaderC;
	vm.Boot -> MainC.Boot;
}