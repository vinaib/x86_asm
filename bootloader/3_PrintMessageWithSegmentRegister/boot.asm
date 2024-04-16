; nasm -f bin ./boot.asm -o ./boot.bin    ; assemble to binary as we have to run in qemu
; ndisasm ./boot.bin                      ; disassembly of boot.bin
; qemu-system-x86_64 -hda boot.bin        ; this virtual system will print a. -hda (hard drive)

; Print Hello World program

; For example, 
; if the Bios sets our data segment to 0x7C0 and our assembly program's origin is 0x7C00, then
; the equation that will be dealt will be (DS * 16) + 0x7C00.
; 0x7C00 + 0x7C00, which does not point to our message
; Because of these types of scenarios, it makes sense for us to initialize the data segment and all the
; other segment registers ourself.


org 0x0  ; origin at 0x0

BITS 16     ; tells the assembler that we are using 16bit architecture
            ; so that assembler assembles only 16bit instructions

jmp 0x7c0:start    ; ensures that our CS is at 0x7c0
start:
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