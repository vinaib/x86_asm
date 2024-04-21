# first boot.bin takes one sector
# second dd gets appended to start of second sector
# third dd fills remaining second sector with zeros
all:
	nasm -f bin ./boot.asm -o ./boot.bin
	dd if=./message.txt >> ./boot.bin
	dd if=/dev/zero bs=512 count=1 >> ./boot.bin