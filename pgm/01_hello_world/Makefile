ASM=nasm
FORMAT_FLAGS=-f elf

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
SET_EMULATION=-m elf_i386

OBJ=pgm.o

%.o: %.asm
	$(ASM) $(FORMAT_FLAGS) $< -o $@

exe: $(OBJ)
	$(LD) $(SET_EMULATION) -o $@ $^


clean:
	rm -rf *.o exe



