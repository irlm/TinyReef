/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques
 * History:   Apr 26, 2010.
 *
 */
 
/**
 * Component JMPR – Jump Register
 * jr Rs # PC = RF[Rs]
 *
 * @author Igor L Marques
 */ 
configuration JmprBytecodeC
{
	provides interface TinyReefBytecode;
}

implementation
{
	components JmprBytecodeM;

  	TinyReefBytecode = JmprBytecodeM.TinyReefBytecode;
}