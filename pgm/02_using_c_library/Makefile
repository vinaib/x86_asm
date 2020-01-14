ASM=nasm
FORMAT_FLAGS_32=-f elf
FORMAT_FLAGS_64=-f elf64

LD=ld
SET_EMULATION_32=-m elf_i386
SET_EMULATION_64=-m elf_x86_64

CC=gcc

OBJ_32=pgm_32.o
OBJ_64=pgm_64.o

exe: exe_32 exe_64

# 32 bit compilation using gcc
# by default gcc builds and links for 64bit. To build it for 32 bit use -m
# option "-m32". Prior to this please install gcc-multilib to have 32 bit
# libraries installed. sudo apt install gcc-multilib g++-multilib
# with this options no issues in compilation but still I see issue in o/p. On
# running ./exe_32 it displays junk. Need to debug
%_32.o: %.asm
	$(ASM) $(FORMAT_FLAGS_32) $< -o $@

exe_32: $(OBJ_32)
	$(CC) -v -no-pie -m32 -o $@ $^
	
# 64 bit compilation using gcc
%_64.o: %.asm
	$(ASM) $(FORMAT_FLAGS_64) $< -o $@

# By default gcc enables "-enable-default-pie". Side effect with this being
# enabled is, If your assembly program which is not position independent, trying
# to link to with C librarires you may see following errors:
#------------------------------------------------------------------------------
# /usr/bin/ld: pgm_64.o: relocation R_X86_64_32 against `.text' can not be used
# when making a PIE object; recompile with -fPIC 
#------------------------------------------------------------------------------
# to overcome this error use -no-pie option to gcc
# on run ./exe_64 it displays "Hello World"


exe_64: $(OBJ_64)
	$(CC) -v -no-pie -o $@ $^

clean:
	rm -rf *.o exe_32 exe_64



