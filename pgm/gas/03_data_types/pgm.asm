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

	movl $1, %eax		#system call
	movl $0, %ebx
	int $0x80

