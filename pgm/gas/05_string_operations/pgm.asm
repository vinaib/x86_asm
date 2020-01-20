# Initialized data segment
	.data
		str_1: .asciz "Hello world\n"
		str_2: .asciz "Linux\n"

# Uninitialized data segment
	.bss
		.lcomm dst_1, 100
		.lcomm dst_2, 100
		.lcomm dst_3, 100

# code segment
	.text
		.globl _start

_start:
		nop

# 1. simple copy using movsb, movsw, movs1

# store address of str_1 in ESI
# store address of dst_1 in DSI
		movl $str_1, %esi
		movl $dst_1, %edi

		movsb
		movsw
		movsl

# 2. getting/clearing the DF flag

# set the DF flag
		std	

# clear the DF flag
		cld

# 3. using rep
		movl $str_1, %esi
		movl $dst_2, %edi
		movl $25, %ecx		#set for rep
		cld					# ensure clear direction flag
		rep movsb
		std
	
# 4. Loading string from memory into EAX register
		cld
# load effective address (lea) instruction. 
# Load memory location of string into esi
		leal str_1, %esi
		lodsb
		movb $0, %al

		dec %esi
		lodsw
		movw $0, %ax

# 5. storing strigs from EAX register to memory
		leal dst_3, %edi
		stosb
		stosw
		stosl

# 6. comparing strings
		cld
		leal str_1, %esi
		leal str_2, %edi
		cmpsb

		dec %esi
		dec %edi
		cmpsw

		subl $2, %esi
		subl $2, %edi
		cmpsl

# exit()
		movl $1, %eax
		movl $0, %ebx
		int $0x80
