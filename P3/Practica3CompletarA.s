.text
	.align 4
	.globl OperaVec
	.type	OperaVec, @function
OperaVec:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl	8(%ebp), %eax #eax <- &Vector
	movl	(%eax), %eax
	movl	%eax, -4(%ebp) #res = vector[0]
# Aqui has de introducir el codigo
	movl -8(%ebp),%ebx   # ebx <- i
	movl $1,%ebx		 # ebx(i) = 1
	movl 12(%ebp), %esi  # esi = elementos

for: cmpl %esi, %ebx 	 # i < elementos
	 jge fi_for			 #salto si i>=elementos
	 movl (%eax,%ebx,4), %ecx   #ecx <- &V+i*4
	 movl -4(%eax,%ebx,4),%edx 	#edx <- (&V+i*4)-4
	 cmpl %ecx,%edx			# v[i] == v[i-1]
	 jne fi_if				#salto si no es compleix
	 movl %ebx,-4(%ebp)		#res = i

fi_if:
	 incl %ebx			#++i
	 jmp for

fi_for:

# El final de la rutina ya esta programado
	movl	-4(%ebp), %eax
	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
