.text
	.align 4
	.globl procesar
	.type	procesar, @function
.data
    .align 16
	zeros: .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

procesar:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi

# Aqui has de introducir el codigo

	movl 8(%ebp), %eax #eax=@mata
	movl 12(%ebp), %ebx #ebx=@matb
	movl 16(%ebp), %ecx #ecx=@matc
	movl 20(%ebp), %edi #edi=n
	imul %edi, %edi #edi=n*n
	movl $0, %esi #esi lo usaremos como contador
    
for:
	cmpl %esi, %edi
	je fi_for

	movdqa (%eax, %esi), %xmm1
	movdqa (%ebx, %esi), %xmm2
	psubb %xmm2, %xmm1
	pcmpgtb zeros, %xmm1
	movdqa %xmm1, (%ecx, %esi)
	addl $16, %esi #++contador
	jmp for
	
fi_for:

# El final de la rutina ya esta programado

	emms	# Instruccion necesaria si os equivocais y usais MMX
	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
