ASM=as
FORMAT_FLAGS_32=--32
FORMAT_FLAGS_64=--64

LD=ld
SET_EMULATION_FLAGS_32=-m elf_i386
SET_EMULATION_FLAGS_64=-m elf_x86_64

OBJ_32=pgm_32.o
OBJ_64=pgm_64.o

exe: exe_32 exe_64 

%_32.o: %.asm
	$(ASM) $(FORMAT_FLAGS_32) $< -g -o $@

exe_32: $(OBJ_32)
	$(LD) $(SET_EMULATION_FLAGS_32) -o $@ $^
	
%_64.o: %.asm
	$(ASM) $(FORMAT_FLAGS_64) $< -g -o $@

exe_64: $(OBJ_64)
	$(LD) $(SET_EMULATION_FLAGS_64) -o $@ $^

clean:
	rm -rf *.o exe_*

