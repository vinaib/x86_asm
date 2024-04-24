[BITS 32]
; export the symbol _start
global _start

CODE_SEG equ 0x08
DATA_SEG equ 0x10

_start:
   ; set the segment registers
   mov ax, DATA_SEG
   mov ds, ax
   mov es, ax
   mov fs, ax
   mov gs, ax
   mov ss, ax
   mov ebp, 0x00200000
   mov esp, ebp

   ; enable fast A20 line; refer osdev 
   in al, 0x92
   or al, 0x02
   out 0x92, al

   jmp $

   ; fixing aligmnent issues with c code.
   ; and place this asm at last in binary. This
   ; can be controlled from linker.ld file
   times 512-($-$$) db 0