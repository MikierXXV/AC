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
		movl $0, %esi				# i = 0
		movl 8(%ebp), %eax			# @mata
		movl 12(%ebp), %ebx			# @matb
		movl 16(%ebp), %ecx			# @matc
		movl 20(%ebp), %edi			# n
		imull %edi, %edi			# nxn (unico bucle)

for:
		cmpl %edi, %esi
		jge endfor			# saltar si i >= n*n

		movl (%ebx), %edx
		subl (%eax), %edx	# mata[i*n+j] - matb[i*n+j]
		movl %edx, (%ecx)	# matc[i*n+j] = mata[i*n+j] - matb[i*n+j]


		cmpl $0, %edx
		jle else
if:
		movl $255, (%ecx)	# matc[i*n+j]
		jmp endif

else:
		movl $0, (%ecx)		# matc[i*n+j]

endif:
		addl $16, %esi		# i = i + 16;
		addl $16, %eax		# stride
		addl $16, %ebx		# stride
		addl $16, %ecx		# stride
		jmp for

endfor:

# El final de la rutina ya esta programado

	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
