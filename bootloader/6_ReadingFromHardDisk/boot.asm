; nasm -f bin ./boot.asm -o ./boot.bin    ; assemble to binary as we have to run in qemu
; ndisasm ./boot.bin                      ; disassembly of boot.bin
; qemu-system-x86_64 -hda boot.bin        ; this virtual system will print a. -hda (hard drive)

; Program contains
; - set the segment register
; - installs two interrupt handlers in interrupt vector placed at 0x00 location
; - on first sector we have Bios Parameter Block, program to print hello world, code for interrupt handler
; - at the last of sector keep boot signature, indicating that this is a bootblock
; - what ever follows this will be second sector.
; - if you see makefile we are appending message.txt at the end of boot.bin, This text file gets appended and that will be 
;   placed in second sector


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
   mov ax, 0x7c0     ; this code block sets the DS, ES, SS, segment registers
   mov ds, ax        ; set the SP pointer
   mov es, ax
   mov ax, 0x00
   mov ss, ax
   mov sp, 0x7c00    ; here DS, ES, SS all are pointing to same location, stack should point to some different location
   sti               ; enables interrupts

   ; read message.txt from hard disk, see Ralf brown's list for details on this
   mov ah, 0x02   ; read sector command
   mov al, 1      ; one sector to read
   mov ch, 0      ; cylinder low eight bits
   mov cl, 2      ; read sector two
   mov dh, 0      ; head number
   ; don't need to set dl, it is already set by bios when you start your bootloader -hda option 
   mov bx, buffer
   int 0x13       ; invoke read command
   jc error

   mov si, buffer    ; buffer points to second sector
   call print

   jmp $          ; infinite loop

error:
   mov si, error_message
   call print
   jmp $             ; infinite loop

; expects the message address to be in SI register
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

error_message: db 'Failed to load sector',0

times 510-($ - $$) db 0 ; it says that we need to fill at least 510 bytes of data.
dw 0xAA55               ; last two bytes of first sector should contain boot signature
                        ; boot signature, bytes are swaped. As intel is little endian arch
                        ; $$ represents the beginning of the .text section.
                        ; $ represents the current position within the .text section.
                        ; $ - $$ calculates the size of the .text section by subtracting the beginning position from the current position.

buffer:                 ; create label for placing the read contents in to this buffer
                        ; this is placed after first boot sector
                        ; this point to second sector