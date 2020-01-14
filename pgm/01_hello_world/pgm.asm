section .data
msg		db		'Hello world!',0Ah	;assign msg variable with your message

section .text
global _start

_start:
	mov edx,13			;number of bytes to write - one for each letter plus 0Ah
						;(line feed character)
	mov ecx,msg			; move the memory address of our message string into ecx
	mov ebx,1			; write to the stdout file
	mov eax,4			;invoke (kernel opcode 4) SYS_WRITE (
						;uint_32 fd,				//ebx
						;const char __user *buf, 	//ecx
						;size_t count)				// edx
	int 80h

	mov ebx,0			; argument 0 for sys_exit, indicates success
	mov eax,1			; sys_exit (kernel opcode 1)
	int 80h
