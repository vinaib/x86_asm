#include "kernel.h"
#include "utilities.h"
#include "videoCharDisplay.h"
#include <stdint.h>
#include "idt/idt.h"


void kernel_main()
{
   initializeVideoMem();

   // putChar(0,0,'A',2);
   // putChar(1,0,'B',3);
   // putChar(2,0,'C',4);
   // putChar(3,0,'D',5);
   // putChar(4,0,'E',6);
   // putChar(5,0,'F',7);
   
   writeChar('A',2);
   writeChar('B',3);
   writeChar('C',4);
   writeChar('D',5);
   writeChar('E',6);
   writeChar('F',7);

   print("\nABCDECF\nGHIJKLMN");

   // initialize interrupt descriptor table
   idt_init();

   // function triggers divide by zero error
   // problem();
}