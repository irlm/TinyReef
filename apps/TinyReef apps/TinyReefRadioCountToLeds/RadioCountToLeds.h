/*
 * RadioCountToLeds.h
 *
 *  Created on: 27/07/2010
 *      Author: igor
 */

#ifndef RADIOCOUNTTOLEDS_H_
#define RADIOCOUNTTOLEDS_H_

#include "../../TinyReefCompilerLib/TinyReefLib.h"


typedef struct radio_count_msg
{
	uint16_tr counter;
} radio_count_msg_t;

enum {
  AM_RADIO_COUNT_MSG = AM_TINYREEF_APPLICATION
};

#endif /* RADIOCOUNTTOLEDS_H_ */
