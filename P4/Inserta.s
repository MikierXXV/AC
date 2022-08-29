 .text
	.align 4
	.globl Insertar
	.type Insertar,@function
Insertar:
        # Aqui viene vuestro codigo

			pushl %ebp
			movl  %esp,%ebp
			subl  $12, %esp 			#-12 pila
			pushl %esi
			pushl %edi
			pushl %ebx
			movl $0, %esi				# i -> esi
			movl 8(%ebp), %edx 			# @v -> ebx
			movl $-1, -4(%ebp)			# lug = -1

do:			movl 16(%ebp), %eax 		# k -> eax
			imul $12, %esi, %ebx		# 12*i
			movl 4(%ebx,%edx), %ebx 	# v[i].k
if:			cmpl %ebx, %eax
			jge  else_1
			movl %esi,-4(%ebp) 			# lug = i
			jmp while 

else_1:		incl %esi					# ++i

while:		cmpl $0x80000000, %ebx		
			jne do
			
			cmpl $0x80000000, %ebx
			jne while_2
			movl %esi, %ebx				# lug = i
			jmp for_1	

while_2:	cmpl $0x80000000, %ebx
			je for_1
			incl %esi					# ++i

for_1:		movl %esi, %edi				# j = i
			cmpl -4(%ebp),%edi
			jl end_for
			imul $12,%edi,%eax			
			movl (%edx, %eax), %ebx
			movl (%edx, %eax, 4), %ecx
			movl %ebx, %ecx

			movl 4(%edx, %eax), %ebx
			movl (%edx, %eax, 4), %ecx
			movl %ebx, %ecx

			movl 8(%edx, %eax), %ebx
			movl (%ebx),%ebx
			movl (%edx, %eax, 4), %ecx
			movl (%ecx),%ecx
			movl %ebx, %ecx

			decl  %edi
			jmp for_1

end_for:
			pushl %edx
			movl 12(%ebp), %eax
			pushl %eax
			movl -4(%ebp), %ebx
			pushl %ebx
			call Asignar
			addl $1,%esi
			movl %esi, %eax 	# return

			popl %ebx
			popl %edi
			popl %esi
			movl %ebp,%esp
end:  		popl %ebp
			ret


