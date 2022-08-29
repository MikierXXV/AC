.text
	.align 16
	.globl procesar
	.type	procesar, @function


uno:  .byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
cero: .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

procesar:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi

# Aqui has de introducir el codigo
	movl $0, %edi				# i 
	movl 8(%ebp), %ebx  		# *matA -> %ebx
	movl 12(%ebp), %ecx			# *matB -> %ecx		
	movl 16(%ebp), %edx			# n-> %edx
	movl 20(%ebp), %esi			# j

for:
	cmpl %edx, %edi
	jge end_for

for_1: 
	cmpl %edx, %esi
	jge fi_for
	movdqa uno,%xmm0			# muevo a xmm0 uno(variable de 16)
	pand (%ebx, %edi), %xmm0	# & 1
	pcmpgtb cero, %xmm0			# multiple de 16
	movdqa %xmm0, (%ecx,%esi)
	addl $16, %esi
	jmp for_1

fi_for:
	addl $16, %edi				# i += 16
	jmp for 	

end_for:


# El final de la rutina ya esta programado

	emms	# Instruccion necesaria si os equivocais y usais MMX
	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
