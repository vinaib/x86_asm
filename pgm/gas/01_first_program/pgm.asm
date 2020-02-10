	.text

	.globl _start

_start:

#64 bit	
#		mov $2,%rax
#		mov $3,%rbx
#		mov $4,%rcx

# 64 bit syscall
#		mov $60,%rax			#64 bit mode
#		mov $0,%rdi			#argument
#		syscall				#raise software interrupt(man syscall)

# 32 bit
		mov $2,%eax
		mov $3,%ebx
		mov $4,%ecx

		mov $2,%ax
		mov $3,%bx
		mov $4,%cx

# 32 bit syscall
		movl $1, %eax		#32 bit mode
		movl $0, %ebx		#argument
		int $0x80			#32 bit raise software interrupt


