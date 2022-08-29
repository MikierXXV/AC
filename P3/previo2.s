	.file	"previo2.c"
	.text
	.comm	Matriz,400,32
	.comm	i,4,4
	.comm	j,4,4
	.comm	ResFila,40,32
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, i(%rip)
	movl	$0, j(%rip)
	movl	$1, ResFila(%rip)
	jmp	.L2
.L5:
	movl	i(%rip), %eax
	movl	j(%rip), %edx
	movslq	%edx, %rcx
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	Matriz(%rip), %rax
	movl	(%rdx,%rax), %eax
	cmpl	$100, %eax
	jle	.L4
	movl	i(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	ResFila(%rip), %rax
	movl	(%rdx,%rax), %ecx
	movl	i(%rip), %eax
	movl	j(%rip), %edx
	movslq	%edx, %rsi
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rsi, %rax
	leaq	0(,%rax,4), %rdx
	leaq	Matriz(%rip), %rax
	movl	(%rdx,%rax), %edx
	movl	i(%rip), %eax
	subl	%edx, %ecx
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	ResFila(%rip), %rax
	movl	%ecx, (%rdx,%rax)
.L4:
	movl	j(%rip), %eax
	addl	$1, %eax
	movl	%eax, j(%rip)
.L3:
	movl	i(%rip), %eax
	movl	j(%rip), %edx
	movslq	%edx, %rcx
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	Matriz(%rip), %rax
	movl	(%rdx,%rax), %eax
	testl	%eax, %eax
	jne	.L5
	movl	i(%rip), %eax
	addl	$1, %eax
	movl	%eax, i(%rip)
	movl	$0, j(%rip)
	movl	i(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	ResFila(%rip), %rax
	movl	$1, (%rdx,%rax)
.L2:
	movl	i(%rip), %eax
	cmpl	$9, %eax
	jle	.L3
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
