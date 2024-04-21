; nasm -f bin ./boot.asm -o ./boot.bin    ; assemble to binary as we have to run in qemu
; ndisasm ./boot.bin                      ; disassembly of boot.bin
; qemu-system-x86_64 -hda boot.bin        ; this virtual system will print a. -hda (hard drive)

; Program contains
; - set the segment register
; - installs two interrupt handlers in interrupt vector placed at 0x00 location
; - on first sector we have Bios Parameter Block, program to print hello world, code for interrupt handler
; - at the last of sector keep boot signature, indicating that this is a bootblock



org 0x7c00  ; origin at 0x0

[BITS 16]     ; tells the assembler that we are using 16bit architecture
            ; so that assembler assembles only 16bit instructions

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

_start:
   jmp short start1
   nop

times 33 db 0        ; place holder for bios parameter block

start1:
   jmp 0x0:start2    ; ensures that our CS is loaded with 0x7c0

start2:
   cli               ; clear interrupt flag, disables interrupts
   mov ax, 0x0     ; this code block sets the DS, ES, SS, segment registers
   mov ds, ax        ; set the SP pointer
   mov es, ax
   mov ss, ax
   mov sp, 0x7c00    ; here DS, ES, SS all are pointing to same location, stack should point to some different location
   sti               ; enables interrupts

load_protected:
   cli
   lgdt[gdt_descriptor]
   mov eax, cr0      ; read control register 0 to eax; 32bit 
   or eax, 0x1       ; set protected mode
   mov cr0, eax      ; write back to control reg 0
   jmp CODE_SEG:load32

; GDT
gdt_start:
gdt_null:
   dd 0x0
   dd 0x0

; offset 0x8
gdt_code:     ; CS SHOULD POINT TO THIS
    dw 0xffff ; Segment limit first 0-15 bits
    dw 0      ; Base first 0-15 bits
    db 0      ; Base 16-23 bits
    db 0x9a   ; Access byte
    db 11001111b ; High 4 bit flags and the low 4 bit flags
    db 0        ; Base 24-31 bits

; offset 0x10
gdt_data:      ; DS, SS, ES, FS, GS
    dw 0xffff ; Segment limit first 0-15 bits
    dw 0      ; Base first 0-15 bits
    db 0      ; Base 16-23 bits
    db 0x92   ; Access byte
    db 11001111b ; High 4 bit flags and the low 4 bit flags
    db 0        ; Base 24-31 bits

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start-1  ; size of gdt descriptor table
    dd gdt_start              ; address of gdt_descriptor table
 
; load 100 sectors of kernel
[BITS 32]
load32:
   mov eax, 1           ; starting sector to load, In zero sector we have boot loader and we dont want to load that
   mov ecx, 100         ; number of sectors to load
   mov edi, 0x0100000   ; address where to load
   call ata_lba_read
   jmp CODE_SEG:0x0100000
    
ata_lba_read:
   mov ebx, eax   ; backup the lba
   ; send the highest 8 bits of lba to hard disk controller
   shr eax, 24
   or eax, 0xE0 ; select the master drive
   mov dx, 0x1F6
   out dx, al
   ;finished sending the highest 8 bits of the lba

   ; send the total sectors to read
   mov eax, ecx
   mov dx, 0x1f2
   out dx, al
   ; finished sending total sectors to read
   
   ; send more bits to LBA
   mov eax, ebx ; reset the backup LBA
   mov dx, 0x1f3
   out dx, al
   ;finished sending more bits of the lBA

   mov dx, 0x1f4
   mov eax, ebx ; restore the backup lba
   shr eax,8
   out dx, al
   ; finished sending more bits of the Lba

   ; send upper 16 bits of the lba
   mov dx, 0x1f5
   mov eax, ebx
   shr eax, 16
   out dx, al
   ; finished sending upper 16 bits of the lba

   mov dx, 0x1f7
   mov al, 0x20
   out dx, al

   ;read all sectors into memory
.next_sector:
   push ecx

   ;checking if we need to read
.try_again:
   mov dx, 0x1f7
   in al, dx
   test al,8
   jz .try_again

; we need to read 256 words at a time
   mov ecx, 256
   mov dx, 0x1f0
   rep insw       ; read 256 times
   pop ecx
   loop .next_sector ;also decrements
   ; end of reading sectors into memory
   ret



times 510-($ - $$) db 0 ; it says that we need to fill at least 510 bytes of data.
dw 0xAA55               ; last two bytes of first sector should contain boot signature
                        ; boot signature, bytes are swaped. As intel is little endian arch
                        ; $$ represents the beginning of the .text section.
                        ; $ represents the current position within the .text section.
                        ; $ - $$ calculates the size of the .text section by subtracting the beginning position from the current position.
