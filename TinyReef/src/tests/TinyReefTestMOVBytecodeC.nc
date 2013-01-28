
#include "TinyReef.h"

configuration TinyReefTestMOVBytecodeC
{
}

implementation
{
	components MainC, TinyReefTestMOVBytecodeM;
	
	TinyReefTestMOVBytecodeM.Boot  -> MainC.Boot;
}