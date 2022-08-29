.text
	.align 4
	.globl OperaMat
	.type	OperaMat, @function
OperaMat:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
# Aqui has de introducir el codigo
    movl    $0, -4(%ebp) # res = 0
    movl    $0, %eax # i = 0
    movl    8(%ebp), %edx # @V
    

for1:
    cmpl    $3, %eax # i < 3
    jge     fi
    movl    $0, %ecx # j = 0
    
for2:
    cmpl    %eax, %ecx # j <= i
    jg      fi_for2
    imul    $3, %eax, %ebx # i*3
    addl    %ecx, %ebx # i*3+j
    movl    (%edx, %ebx, 4), %ebx #@V + (i*3+j)*4
    addl    %ebx, -4(%ebp)  #res += Matriz[i][j]
    incl    %ecx    # ++j
    jmp     for2

fi_for2:
    addl    12(%ebp), %eax  # i+= salto
    jmp     for1

fi:

# El final de la rutina ya esta programado
	movl	-4(%ebp), %eax
	popl	%edi
	popl	%esi
	popl	%ebx	
	movl %ebp,%esp
	popl %ebp
	ret
