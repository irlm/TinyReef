/*
 * RadioSenseToLeds.h
 *
 *  Created on: 27/07/2010
 *      Author: igor
 */

#ifndef RADIOSENSETOLEDS_H_
#define RADIOSENSETOLEDS_H_

#include "../../TinyReefCompilerLib/TinyReefLib.h"

typedef struct radio_sense_msg
{
	//uint8_tr error;
	uint8_tr data;
} radio_sense_msg_t;

enum {
  AM_RADIO_SENSE_MSG = AM_TINYREEF_APPLICATION
};
#endif /* RADIOSENSETOLEDS_H_ */
