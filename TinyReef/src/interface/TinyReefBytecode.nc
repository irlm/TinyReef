/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/*
 * Authors:   Igor L Marques, Jobson Ronan
 * History:   Set 17, 2009.
 *
 */

#include "TinyReef.h"

interface TinyReefBytecode
{
    command error_t execute(tinyReefContext_t *const context, uint32_t instruction);
}
