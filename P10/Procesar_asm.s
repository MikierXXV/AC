.text
	.align 4
	.globl procesar
	.type	procesar, @function
procesar:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi

# Aqui has de introducir el codigo
	movl $0, %edi
	movl 8(%ebp), %ebx  		# *matA -> %ebx
	movl 12(%ebp), %ecx			# *matB -> %ecx		
	movl 16(%ebp), %edx			# n-> %edx
	imul %edx, %edx				# n² -> %edx

for:
	cmpl %edx, %edi				# i < n
	jge  end_for
	movb (%ebx,%edi), %al		# mata[i*n+j]
	andb  $1, %al				# mata[i*n+j] & 1

if: 
	cmpb $0,%al					# matb[i*n+j] > 0
	jle else_1
	movb $255, (%ecx,%edi)		# matb[i*n+j] = 255
	jmp fi 

else_1:
	movb $0, (%ecx,%edi)		# matb[i*n+j] = 0;

fi:
	incl %edi					# ++i
	jmp for

end_for:


# El final de la rutina ya esta programado

	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
