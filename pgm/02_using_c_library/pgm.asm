		section	.data
msg		db "Hello world!",0		;assign msg variable with your message

		section .text
		global main
		extern puts

main:					; This is called by the c library startup code
		mov edi,msg		; First argument in rdi, 
						; for 32 bit compilation usage of rdi gives error. 
						; It says instruction not supported. 
						; use edi
						; for 64 bit compilation only use
						; rdi
		call puts		; puts(message)
		ret				; return from main back into C library wrapper

