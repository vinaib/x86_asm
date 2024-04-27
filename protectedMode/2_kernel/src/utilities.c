#include "utilities.h"
#include "videoCharDisplay.h"

/**
 * @brief string len utility function
 * 
 * @param str 
 * @return size_t lenght of string
 */
size_t strlen(const char* str)
{
   size_t len = 0;

   while(str[len++] != '\0');
   
   return len;
}

/**
 * @brief print string on terminal
 * 
 * @param str 
 */
void print(const char* str)
{
   size_t len = strlen(str);

   for(int i=0; i<len; i++)
   {
      writeChar(str[i], 15);
   }
}


