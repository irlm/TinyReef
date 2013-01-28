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

interface TinyReefMemoryAccess
{
    command uint8_t getByte(tinyReefContext_t *const context, uint32_t addr);
    
    command void setByte(tinyReefContext_t *const context, uint32_t addr, uint8_t _byte);
    
    command uint16_t getHalfWord(tinyReefContext_t *const context, uint32_t addr);
    
    command void setHalfWord(tinyReefContext_t *const context, uint32_t addr, uint16_t _halfWord);
    
    command uint32_t getWord(tinyReefContext_t *const context, uint32_t addr);
    
    command void setWord(tinyReefContext_t *const context, uint32_t addr, uint32_t _word);
}
