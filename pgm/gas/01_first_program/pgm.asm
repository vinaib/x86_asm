	.text

	.globl _start

_start:
		movl $1, %eax		#32 bit mode
		movl $0, %ebx		#argument
		int $0x80			#32 bit raise software interrupt

#		mov $1,%rax			#64 bit mode
#		mov $0,%rdi			#argument
#		syscall				#raise software interrupt(man syscall)

