#include "videoCharDisplay.h"

/**
 * @brief uint16_t array
 * first byte of uint16_t has the ascii character
 * second byte of unint16_t has the color code
 */
uint16_t *videoMem = 0;
static uint16_t xPos = 0;
static uint16_t yPos = 0;


/**
 * @brief makeChar encodes the given color and ascii character in a little endian format
 * 
 * @param c
 * @param color
 * @return uint16_t
 * 
 * videoMem[0] = 0x02 41
 * 2 = color code
 * 41 = ascii value of 'A'
 **/
static uint16_t makeChar(char c, char color)
{
   return (color << 8) | c;
}

/**
 * @brief 
 * 
 * @param x 
 * @param y 
 * @param c 
 * @param color 
 */
void putChar(int x, int y, char c, char color)
{
   videoMem[(y*VGA_WIDTH)+x] = makeChar(c, color);
}

/**
 * @brief writeChar keeps track of xPos and yPos
 * 
 * @param c 
 * @param color 
 */
void writeChar(char c, char color)
{
   if( '\n' == c)
   {
      yPos += 1;
      xPos =0;
      return;
   }

   putChar(xPos, yPos, c, color);

   xPos += 1;

   if(xPos > VGA_WIDTH)
   {
      xPos = 0;
      yPos = yPos + 1;
   }
}

/**
 * @brief initialize video mem
 * 
 */
void initializeVideoMem()
{
   videoMem = (uint16_t*)(0xB8000);
   xPos = 0;
   yPos = 0;

   for(int y=0; y< VGA_HEIGHT; y++)
   {
      for(int x=0;x<VGA_WIDTH;x++)
      {
         putChar(x,y,' ',0);
      }
   }
}

/**
 * @brief accessing video memory sequentially
 * 
 */
void videoMemInChar()
{
   for(int i = 0; i<(VGA_HEIGHT * VGA_WIDTH); i++)
   {
      videoMem[i] = 0;
   }

   videoMem[0] = 'A';
   videoMem[1] = 2;
   videoMem[2] = 'B';
   videoMem[3] = 23;
   videoMem[4] = 'C';
   videoMem[5] = 4;
   videoMem[6] = 'D';
   videoMem[7] = 5;
   videoMem[8] = 'E';
   videoMem[9] = 6;
}

