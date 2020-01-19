# Disassembly of all sections
#objdump -D exe_32
#objdump -D exe_64

# Dump elf header
#readelf -h exe_32
#readelf -h exe_64

#size -A exe_32/size -B exe_32
#size -A exe_64/size -B exe_64

# refer program
#gdb -q exe_32
#x/12cb	<address> print 12 character of byte size
#x/1db <address> print 1 decimal of byte size
#x/1dw <address> print 1 decimal of word size
#x/1dh <address> print 1 decimal of half word size
#x/5dw <address> print int_array of 5 elements, decimal of size word
#x/100db 0x080490b0 : prints first 100 bytes of large buffer

#print address of variable along with its value
#x/1dh &int_16
#x/1dw &int_32 (or)
#print (int *)int_32

#following instruction stores address of int_32 to reg eax
#movl $int_32 %eax

#move data at %eax to %ebx
#movl (%eax), %ebx

#move constant at address pointed by eax
#movl $9, (%eax)

ASM=as
FORMAT_FLAGS_32=--32
FORMAT_FLAGS_64=--64

DEBUG_FLAGS=-gstabs

LD=ld
SET_EMULATION_FLAGS_32=-m elf_i386
SET_EMULATION_FLAGS_64=-m elf_x86_64

OBJ_32=pgm_32.o
OBJ_64=pgm_64.o

exe: exe_32 exe_64 

%_32.o: %.asm
	$(ASM) $(FORMAT_FLAGS_32) $(DEBUG_FLAGS) $< -o $@

exe_32: $(OBJ_32)
	$(LD) $(SET_EMULATION_FLAGS_32) -o $@ $^
	
%_64.o: %.asm
	$(ASM) $(FORMAT_FLAGS_64) $(DEBUG_FLAGS) $< -o $@

exe_64: $(OBJ_64)
	$(LD) $(SET_EMULATION_FLAGS_64) -o $@ $^

clean:
	rm -rf *.o exe_*

