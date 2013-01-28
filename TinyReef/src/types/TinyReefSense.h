#ifndef TINY_REEF_SENSE_H
#define TINY_REEF_SENSE_H

enum SenseTypes
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
};

typedef struct senseTableEntry
{
	//Programming Hint 7: don’t declare variables with an enum type
	error_t error;
	uint32_t dataMemoryAddress;
	uint8_t dataLength;
} senseTableEntry_t;

#endif /* TINY_REEF_SENSE_H */
