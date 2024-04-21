/* program entry point */
ENTRY(_start)
OUTPUT_FORMAT(binary)

SECTIONS
{
   /*    
   1. what we're saying here is is that our kernel will be loaded into one megabyte into memory 
   2. Compiling our kernel with this linker script saying dot equals one m, we are required to load our kernel at one Meg into memory.
   3. linker is creating addresses based on this origin.
   */
   . = 1M;

   /* text section */
   .text :
   {
      *(.text)
   }

   .rodata :
   {
      *(.rodata)
   }

   .data :
   {
      *(.data)
   }

   .bss :
   {
      *(COMMON)
      *(.bss)
   }
}