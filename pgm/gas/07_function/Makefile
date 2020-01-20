#to display string in gdb
# x/s &str_1
# x/s &str_2

# print single cpu register
# p $esi		# decimal format
# p /x $esi		# hex format

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
	$(ASM) $(DEBUG_FLAGS) $(FORMAT_FLAGS_32) $< -o $@

exe_32: $(OBJ_32)
	$(LD) $(SET_EMULATION_FLAGS_32) -o $@ $^
	
%_64.o: %.asm
	$(ASM) $(DEBUG_FLAGS) $(FORMAT_FLAGS_64) $< -o $@

exe_64: $(OBJ_64)
	$(LD) $(SET_EMULATION_FLAGS_64) -o $@ $^

clean:
	rm -rf *.o exe_*

