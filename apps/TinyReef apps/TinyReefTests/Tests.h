/*
 * RadioSenseToLeds.h
 *
 *  Created on: 27/07/2010
 *      Author: igor
 */

#ifndef TESTS_H_
#define TESTS_H_

#include "../../TinyReefCompilerLib/TinyReefLib.h"

typedef struct test_msg
{
	uint16_tr data;
} test_msg_t;

enum {
  AM_TEST_MSG = AM_TINYREEF_APPLICATION
};

#endif /* TESTS_H_ */
