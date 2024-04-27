#ifndef __VIDEOCHARDISPLAY_H__
#define __VIDEOCHARDISPLAY_H__

#include <stdint.h>

#define VGA_WIDTH 80
#define VGA_HEIGHT 20

extern uint16_t *videoMem;

void initializeVideoMem();

void putChar(int x, int y, char c, char color);

void writeChar(char c, char color);

#endif // __VIDEOCHARDISPLAY_H__