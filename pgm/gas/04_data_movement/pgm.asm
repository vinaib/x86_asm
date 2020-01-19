# Demo for data types

	.data

	string: 	.ascii "Hello world"
	one_byte:	.byte	10
	int_32:		.int	2
	int_16:		.short	3
	Flt:		.float	10.23
	int_array:	.int 10,20,30,40,50

	.bss

	.comm	lrg_buff, 10000

	.text

	.globl	_start

_start:
	nop

# mov immediate value into register;	eax = 10
	movl $10, %eax
	
# mov immediate value into memory location; int_32 = 50
	movw $50, int_16

#mov data between registers
	movl %eax, %ebx

#move data from memory to register
	movl int_32, %eax

#move data from register to memory
	movb $3, %al
	movb %al, one_byte

#mov data into an indexed memory location
#location is decided by BaseAddress(offset, Index, DataSize)
#offset and index must be registers, datasize can be a numerical value
	movl $0, %ecx
	movl $2, %edi
	movl $22, int_array(%ecx, %edi, 4)

# Indirect addressing using registers
	movl $int_32, %eax
	movl (%eax), %ebx
	movl $9, (%eax)

	movl $1, %eax		#system call
	movl $0, %ebx
	int $0x80

