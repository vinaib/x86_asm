ASM=nasm
FORMAT_FLAGS_32=-f elf
FORMAT_FLAGS_64=-f elf64

LD=ld
# -m: set emulation
# Supported emulations:
#  elf_x86_64
#  elf32_x86_64
#  elf_i386
#  elf_iamcu
#  i386linux
#  elf_l1om
#  elf_k1om
#  i386pep
#  i386p
# On using elf_x86_64:
# I see following output during ld
# ld: i386 architecture of input file `pgm.o' is incompatible with i386:x86-64 output
# need to explore more on this, why I have to use only elf_i386

# Format flag "-f elf" and emulation: elf_i386, file exe shows following o/p: Makes o/p as 32bit binary:
# exe: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, not stripped
SET_EMULATION_32=-m elf_i386

SET_EMULATION_64=-m elf_x86_64

OBJ_32=pgm_32.o
OBJ_64=pgm_64.o

exe: exe_32 exe_64

%_32.o: %.asm
	$(ASM) $(FORMAT_FLAGS_32) $< -o $@

exe_32: $(OBJ_32)
	$(LD) $(SET_EMULATION_32) -o $@ $^
	
%_64.o: %.asm
	$(ASM) $(FORMAT_FLAGS_64) $< -o $@

exe_64: $(OBJ_64)
	$(LD) $(SET_EMULATION_64) -o $@ $^

clean:
	rm -rf *.o exe_32 exe_64



