#include<stdio.h>

int main()
{
	/* Add 10 and 20 and store result in to reg %eax */
	__asm__ (	"movl $10, %eax;"
				"movl $20, %ebx;"
				"addl %ebx, %eax;"
			);


	/* sub 20 from 10 and store result in to reg %eax */
	__asm__ (	"movl $10, %eax;"
				"movl $20, %ebx;"
				"subl %ebx, %eax;"
			);
		
	/* multiply 10 and 20 store result in to ref %eax*/
	__asm__ (	"movl $10, %eax;"
				"movl $20, %ebx;"
				"imull %ebx, %eax;"
			);

	return 0;
}
