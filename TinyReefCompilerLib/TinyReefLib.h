/*
 * TinyReefLib.h
 *
 *  Created on: 18/05/2010
 *      Author: igor
 */

#ifndef TINYREEFLIB_H_
#define TINYREEFLIB_H_

#define AM_BROADCAST_ADDR 0xFFFF


typedef char int8_tr;
typedef unsigned char uint8_tr;
typedef short int int16_tr;
typedef unsigned short int uint16_tr;
typedef int int32_tr;
typedef unsigned int uint32_tr;


typedef enum MESSAGE_ID_ENUM
{
	AM_TINYREEF_APPLICATION = 6,
	AM_TINYREEF_PROGRAM_UPDATE_MESSAGE = 9,
	AM_TINYREEF_POLICY_UPDATE_MESSAGE = 11,
	AM_TINYREEF_REQUEST_MESSAGE = 13
} MESSAGE_ID;

typedef enum Led_State_enum
{
	LED_OFF = 0,
	LED_ON = 1
} Led_State;

typedef enum Led_enum
{
	LED_RED = 1,
	LED_GREEN = 2,
	LED_YELLOW = 4
} LED;

typedef enum tinyReefSyscall_enum
{
	//default
	SYSCALL_PRINT_INT = 0x01, //Print an Integer 1 $a0 = Integer Value to be Printed
	SYSCALL_PRINT_FLOAT = 0x02, //Print Float 2
	SYSCALL_PRINT_DOUBLE = 0x03, //Print Double 3
	SYSCALL_PRINT_STRING = 0x04, //Print String 4 $a0 = Address of String in Memory
	SYSCALL_READ_INT = 0x05, //Read an Integer in 5 Integer Returned in $v0 (from the keyboard)
	SYSCALL_READ_FLOAT = 0x06, //Read Float 6
	SYSCALL_READ_DOUBLE = 0x07, //Read Double 7
	SYSCALL_READ_STRING = 0x08, //Read a String in 8 $a0 = Address of Input Buffer in Memory (from the keyboard) $a1 = Length of Buffer (n)
	SYSCALL_SBRK = 0x09, //Sbrk 9 $a0 = amount Address in $v0
	SYSCALL_EXIT = 0x0A, //Exit 10

	//custom
	SYSCALL_RECEIVE = 0x0B,
	SYSCALL_SEND = 0x0C,
	SYSCALL_SENSE = 0x0D,
	SYSCALL_SET_LED = 0x0E,
	SYSCALL_TIMER = 0x0F,
	SYSCALL_TOGGLE_LED = 0x10,
	SYSCALL_SET_LED_STATE = 0x11
} tinyReefSyscall_enum;

typedef enum SenseTypes
{
	TEMPERATURE = 0x00,
	HUMIDITY,
	BAROMETRIC_PRESSURE,
	AMBIENT_LIGHT,
	X_AXIS_ACCELEROMETER,
	Y_AXIS_ACCELEROMETER,
	GPS,
	VOLTAGE,
	
	NUMBER_OF_SENSE_TYPES_SUPPORTED
}SenseTypes_enum;

//------------------------ EXIT ------------------------------------------
void exitTinyReef(void);
//------------------------------------------------------------------------

//------------------------ COMMUNICATION ---------------------------------
void startReceiveTinyReef(uint8_tr* data, uint8_tr dataLength,
	void(*function)(), void (*Endfunction)());

void sendTinyReef(uint16_tr DestinationAddress, uint8_tr id,
	uint8_tr* dataMemoryAddress, uint8_tr dataLength);

//------------------------------------------------------------------------

//------------------------ SENSE -----------------------------------------
void senseTinyReef(SenseTypes_enum SenseType, uint8_tr* dataMemoryAddress,
	uint8_tr dataLength);
//------------------------------------------------------------------------

//------------------------ TIMER -----------------------------------------
void startTimerTinyReef(uint32_tr dt, void(*function)(), void (*Endfunction)());
//------------------------------------------------------------------------


//------------------------ LEDS ------------------------------------------
void toggleLedTinyReef(LED led);

void setLedStateTinyReef(LED led, Led_State state);

void setLedTinyReef(uint8_tr val);
//------------------------------------------------------------------------

#endif /* TINYREEFLIB_H_ */
