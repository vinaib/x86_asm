#include<stdio.h>

/* Source:
 * https://www.codeproject.com/Articles/15971/Using-Inline-Assembly-in-C-C
   
   In extended assembly, we can also specify the operands. It allows us to
   specify the input registers, output registers and a list of clobbered
   registers.

   asm ( "assembly code"
           : output operands                  // optional 
           : input operands                   // optional 
           : list of clobbered registers      // optional 
		);

	eg:1
	asm ("movl %%eax, %0;" : "=r" ( val ));

	In this example, the variable "val" is kept in a register, the value in
	register eax is copied onto that register, and the value of "val" is updated
	into the memory from this register.

	When the "r" constraint is specified, gcc may keep the variable in any of
	the available General Purpose Registers. We can also specify the register
	names directly by using specific register constraints.
	
	The register constraints are as follows :
	+---+--------------------+
	| r |    Register(s)     |
	+---+--------------------+
	| a |   %eax, %ax, %al   |
	| b |   %ebx, %bx, %bl   |
	| c |   %ecx, %cx, %cl   |
	| d |   %edx, %dx, %dl   |
	| S |   %esi, %si        |
	| D |   %edi, %di        |
	+---+--------------------+

	eg:2

	int no = 100, val ;
    asm ("movl %1, %%ebx;"
         "movl %%ebx, %0;"
         : "=r" ( val )   // output
         : "r" ( no )     //input
         : "%ebx"         //clobbered register
     );

	 In the above example, "val" is the output operand, referred to by %0 and
	 "no" is the input operand, referred to by %1. "r" is a constraint on the
	 operands, which says to GCC to use any register for storing the operands.

	 Output operand constraint should have a constraint modifier "=" to specify
	 the output operand in write-only mode. There are two %’s prefixed to the
	 register name, which helps GCC to distinguish between the operands and
	 registers. operands have a single % as prefix.

	 The clobbered register %ebx after the third colon informs the GCC that the
	 value of %ebx is to be modified inside "asm", so GCC won't use this
	 register to store any other value.

	 eg:3
	 int arg1, arg2, add ;
	 __asm__ ( "addl %%ebx, %%eax;"
        	: "=a" (add)
        	: "a" (arg1), "b" (arg2) );

	Here "add" is the output operand referred to by register eax. And arg1 and
	arg2 are input operands referred to by registers eax and ebx respectively.
 */

int main()
{
	int arg1, arg2, add, sub, mul, quo, rem;

	printf("Enter two integer: ");
	scanf("%d %d", &arg1, &arg2);


	/* Add 10 and 20 and store result in to reg %eax */
	__asm__ (	"addl %%ebx, %%eax;"
				: "=a" (add)
				: "a" (arg1), 
				  "b" (arg2)
			);


	/* sub 20 from 10 and store result in to reg %eax */
	__asm__ (	"subl %%ebx, %%eax;"
				: "=a" (sub)
				: "a" (arg1),
				  "b" (arg2)
			);
		
	/* multiply 10 and 20 store result in to ref %eax*/
	__asm__ (  "imull %%ebx, %%eax;"
				: "=a" (mul)
				: "a" (arg1),
				  "b" (arg2)
			);
/*
	__asm__ ( "movl $0x0, %%edx;"
			  "movl %2, %%eax;"
			  "movl %3, %%ebx;"
			  "idivl %%ebx;"
			  : "=a" (quo), "=d" (rem)
			  : "l" (arg1), "g" (arg2)
			);
*/
	__asm__ ("movl %0,%%eax\n"
			 "movl %1,%%ebx\n"
			 "movl %2,%%ecx\n"
			 "addl %%eax,%%ebx\n"
			 : "=a"(add)
			 : "a"(arg1), "b"(arg2)
			);

    printf( "%d + %d = %d\n", arg1, arg2, add );
    printf( "%d - %d = %d\n", arg1, arg2, sub );
    printf( "%d * %d = %d\n", arg1, arg2, mul );
  //  printf( "%d / %d = %d\n", arg1, arg2, quo );
   // printf( "%d %% %d = %d\n", arg1, arg2, rem );
    printf( "%d + %d = %d\n", arg1, arg2, add );
	
	return 0;
}
