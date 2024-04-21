; nasm -f bin ./boot.asm -o ./boot.bin    ; assemble to binary as we have to run in qemu
; ndisasm ./boot.bin                      ; disassembly of boot.bin
; qemu-system-x86_64 -hda boot.bin        ; this virtual system will print a. -hda (hard drive)

; Program contains
; - set the segment register
; - installs two interrupt handlers in interrupt vector placed at 0x00 location
; - on first sector we have Bios Parameter Block, program to print hello world, code for interrupt handler
; - at the last of sector keep boot signature, indicating that this is a bootblock


; As per this
; https://wiki.osdev.org/FAT

org 0x0  ; origin at 0x0

BITS 16     ; tells the assembler that we are using 16bit architecture
            ; so that assembler assembles only 16bit instructions

_start:
   jmp short start1
   nop

times 33 db 0        ; place holder for bios parameter block

handle_zero:         ; imterrupt handle for int 0, this handler prints A on console
   mov ah, 0x0e      ; this is divide by zero exception
   mov al, 'A'
   mov bx, 0x0
   int 0x10
   iret              ; return from interrupt

handle_one:         ; imterrupt handle for int 0, this handler prints A on console
   mov ah, 0x0e      ; this is divide by zero exception
   mov al, 'B'
   mov bx, 0x0
   int 0x10
   iret              ; return from interrupt

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

   mov word[ss:0x0], handle_zero    ; install handle_zero at ram location 0x0000, offset two bytes
   mov word[ss:0x02], 0x7c0         ; what is this?, segment address two bytes

   mov word[ss:0x4], handle_one     ; install handle_one at ram location 0x0004
   mov word[ss:0x06], 0x7c0         ; what is this?

   int 0x0                          ; generate interrupt 0, which calls interrupt handler zero to execute

   mov ax, 0x0                       ; triggering divide by zero, this calls the interrupt handler 0, which is a divide by zero exception
   div ax

   int 0x1                          ; generate interrupt 1

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