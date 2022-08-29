.text
		.align 16
		.globl procesar
		.type	procesar, @function
cero:	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
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

				movl %ebp, %edx
				shll 4, %edx
				cmpl $0, %edx
				jne no_multi

for_multi:
				cmpl %edi, %esi
				je end						# saltar si i >= n*n

				movdqa (%eax), %xmm0		# xmm0 = mata[i*n+j]
				movdqa (%ebx), %xmm1		# xmm1 = matb[i*n+j]
				psubb %xmm1, %xmm0			# xmm0 = mata[i*n+j] - matb[i*n+j]
				movdqa %xmm0, (%ecx)		# matc[i*n+j] = mata[i*n+j] - matb[i*n+j]

				movdqa cero, %xmm2			# xmm2 = 0
				pcmpgtb %xmm2, %xmm0
				movdqa %xmm0, (%ecx)
				jmp fi_for


for_no_multi:
				cmpl %edi, %esi
				je end						# saltar si i >= n*n

				movdqu (%eax), %xmm0		# xmm0 = mata[i*n+j]
				movdqu (%ebx), %xmm1		# xmm1 = matb[i*n+j]
				psubb %xmm1, %xmm0			# xmm0 = mata[i*n+j] - matb[i*n+j]
				movdqu %xmm0, (%ecx)		# matc[i*n+j] = mata[i*n+j] - matb[i*n+j]

				movdqu cero, %xmm2			# xmm2 = 0
				pcmpgtb %xmm2, %xmm0
				movdqu %xmm0, (%ecx)
				jmp fi_for

fi_for:
				addl $16, %esi				# i = i + 16;
				#addl $16, %eax				# stride
				#addl $16, %ebx				# stride
				#addl $16, %ecx				# stride
				jmp for

end:
	
# El final de la rutina ya esta programado

	emms	# Instruccion necesaria si os equivocais y usais MMX
	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
