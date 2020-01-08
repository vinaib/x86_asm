ASM=nasm
FORMAT_FLAGS=-f elf

LD=ld
LD_FLAGS=-m elf_i386

OBJ=pgm.o

%.o: %.asm
	$(ASM) $(FORMAT_FLAGS) $< -o $@

exe: $(OBJ)
	$(LD) $(LD_FLAGS) -o $@ $^


clean:
	rm -rf *.o exe



