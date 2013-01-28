#ifndef TINY_REEF_STORAGE_H
#define TINY_REEF_STORAGE_H

#define MAX_PROGRAM_STORAGE	10

struct {
    uint8_t version;
    void *COUNT_NOK(len) data;
    uint16_t len;
} programs[MAX_PROGRAM_STORAGE];


#endif /* TINY_REEF_STORAGE_H */
