 .text
	.align 4
	.globl Asignar
	.type Asignar,@function
Asignar:
        # Aqui viene vuestro codigo
	    pushl %ebp
	    movl %esp,%ebp
	    movl 24(%ebp), %esi		#pos -> esi
	    movl 12(%ebp), %eax		#x.c -> eax
	    movl 8(%ebp), %ebx		#@v -> ebx
first:
	    imul $12,%esi,%esi		
	    movl (%ebx, %esi), %ecx
	    movl %eax, %ecx			#ecx -> @v+pos*124
second:

	    movl 16(%ebp), %eax		#x.k -> eax
	    movl 4(%ebx, %esi), %ecx
	    movl %eax, %ecx			#ecx -> (@v+pos*12)+4
third:
	    movl 20(%ebp), %eax		#x.m -> eax
	    movl (%eax),%eax
	    movl 8(%ebx, %esi), %ecx
	    movl %eax, %ecx			#ecx -> (@v+pos*12)+8
fourth:
	    movl %ebp,%esp
end:  	popl %ebp
		ret

 