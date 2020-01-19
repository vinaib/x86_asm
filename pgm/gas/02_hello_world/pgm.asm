# Hello world

	.data

string:
	.ascii "Hello World\n"

	.text

	.globl _start

_start:
	movl $4, %eax			#write sys call number
	movl $1, %ebx			#fd, stdout
	movl $string, %ecx		#string address to char *
	movl $11, %edx			#length of string 
	int $0x80

	movl $1, %eax
	movl $0, %ebx
	int $0x80
