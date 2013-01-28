#ifndef TINY_REEF_EVENT_H
#define TINY_REEF_EVENT_H

typedef struct eventTableEntry
{
	//Programming Hint 7: don’t declare variables with an enum type
	uint8_t  eventId;
	error_t error;
	uint32_t handlerAddress;
	uint32_t endEventAddress;
} eventTableEntry_t;

enum
{
	MAX_EVENT_TABLE	 = 6
};
	
#endif /* TINY_REEF_EVENT_H */
