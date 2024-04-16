; nasm -f bin ./boot.asm -o ./boot.bin    ; assemble to binary as we have to run in qemu
; ndisasm ./boot.bin                      ; disassembly of boot.bin
; qemu-system-x86_64 -hda boot.bin        ; this virtual system will print a. -hda (hard drive)

; Print Hello World program


; As per this
; https://wiki.osdev.org/FAT

org 0x0  ; origin at 0x0

BITS 16     ; tells the assembler that we are using 16bit architecture
            ; so that assembler assembles only 16bit instructions

_start:
   jmp short start1
   nop

times 33 db 0        ; place holder for bios parameter block

start1:
   jmp 0x7c0:start2    ; ensures that our CS is loaded with 0x7c0

start2:
   cli               ; clear interrupt flag, disables interrupts
   mov ax, 0x7c0
   mov ds, ax
   mov es, ax
   mov ax, 0x00
   mov ss, ax
   mov sp, 0x7c00    ; here DS, ES, SS all are pointing to same location, stack should point to some different location
   sti               ; enables interrupts
   mov si, message   ; si has the address of message label
   call print
   jmp $          ; infinite loop, keep jumping to itself

print:
   mov bx, 0      ; background color
.loop:
   lodsb            ; it will load the character to al register from the SI register and increment SI register
   cmp al, 0         ; if loadsb loads zero to register al, which signifies end of string
   je .done
   call print_char
   jmp .loop
.done:
   ret

print_char:
   mov ah, 0eh    ; reg ah contains commnad to int 0x10, 0xe is command to print character on console   
   int 0x10       ; generate interrupt
   ret


message: db 'Hello World', 0   ; declaring message as a string byte array

times 510-($ - $$) db 0 ; it says that we need to fill at least 510 bytes of data.
dw 0xAA55               ; last two bytes of first sector should contain boot signature
                        ; boot signature, bytes are swaped. As intel is little endian arch
                        ; $$ represents the beginning of the .text section.
                        ; $ represents the current position within the .text section.
                        ; $ - $$ calculates the size of the .text section by subtracting the beginning position from the current position.