.text
	.align 16
	.globl procesar
	.type	procesar, @function

ones: 	.byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
zeros: 	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

procesar:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi

# Aqui has de introducir el codigo
	movl 	$0, %edi
	movl	8(%ebp), %eax		# eax = @mata
	movl	12(%ebp), %ebx		# ebx = @matb
	movl	16(%ebp), %ecx		#n
	movl 	20(%ebp), %esi		#j
	
	

for:	cmpl	%ecx, %edi		# i < n * n ?
	jge	endfor

for_1: cmpl 	%ecx, %esi
	jge fi_for1
	movdqa	ones, %xmm1		# 
	pand	(%eax, %edi), %xmm1	# xmm1 = mata[i] & 1, mata[i + 1] & 1, ..., mata[i + 15] & 1
	pcmpgtb	zeros, %xmm1
	movdqa	%xmm1, (%ebx, %edi)
	addl	$16, %esi
	jmp	for_1

fi_for1:
	addl 	$16, %edi
	jmp for

endfor:

# El final de la rutina ya esta programado

	emms	# Instruccion necesaria si os equivocais y usais MMX
	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
