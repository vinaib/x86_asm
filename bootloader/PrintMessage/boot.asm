; nasm -f bin ./boot.asm -o ./boot.bin    ; assemble to binary as we have to run in qemu
; ndisasm ./boot.bin                      ; disassembly of boot.bin
; qemu-system-x86_64 -hda boot.bin        ; this virtual system will print a


; Bios loads OS boot loader into address 0x7C00 
org 0x7c00  ; origin at 0x7c00, start executing at 0x7c00.
            ; other way of doing this start org at 0x0 and
            ; jump to 0x7c00

BITS 16     ; tells the assembler that we are using 16bit architecture
            ; so that assembler assembles only 16bit instructions
start:
   mov si, message   ; si has the address of message label
   call print
   jmp $          ; infinite loop

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

times 510-($ - $$) db 0 ; last two bytes of first sector should contain boot signature
dw 0xAA55               ; boot signature, bytes are swaped. As intel is little endian arch