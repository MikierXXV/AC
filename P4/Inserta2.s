.text
    .align 4
    .globl Insertar
    .type Insertar,@function
Insertar:
        # Aqui viene vuestro codigo

            pushl %ebp 
            movl %esp, %ebp 
            subl $12, %esp          
            pushl %esi
            pushl %edi
            pushl %ebx
            movl $0, %edx               #i = 0 -> esi
            movl $-1, -4(%ebp)          #lug=-1
            movl 8(%ebp), %ecx          #@v

    do:     movl 4(%ecx, %edx), %eax    # v[i].k
            cmpl %eax, 16(%ebp)
            jge else_1
            movl %esi, -4(%ebp)         #lug = i
            jmp if
    
    else_1: incl %esi                   #++i
    
    while:  cmpl $0x80000000, %eax
            jne do

    if:     cmpl $0x80000000, %eax     
            jne else_2
            movl %esi, -4(%ebp)         #lug = i
    
    else_2: cmpl $0x80000000, %eax
            je fi_w
            incl %esi                   #++i
            imul $12, %esi, %edx        #@v+12*i
            movl 4(%ecx, %edx), %eax
            jmp else_2

    
    fi_w:   movl %esi, %edi             #j = i

    for:    cmpl -4(%ebp), %edi
            jl fi_for
            imul $12, %edi, %edx        #v[j]
            movb (%ecx, %edx), %eax     #v[j].c
            movb %eax, 12(%ecx, %edx)   #v[j+1].c = v[j].c

            movl 4(%ecx, %edx), %eax    #v[j].k
            movl %eax, 16(%ecx, %edx)   #v[j+1].k = v[j].k

            movl 8(%ecx, %edx), %eax    #v[j].m
            movl %eax, 20(%ecx, %edx)   #v[j+1].m = v[j].m
            
            decl %edi                   #--j
            jmp for
        
    fi_for: pushl -4(%ebp)              #lug
            pushl 12(%ebp)              #S1.c
            pushl 16(%ebp)              #S1.x
            pushl 20(%ebp)              #S1.m
            pushl 8(%ebp)               #@v

            call Asignar
            addl $20, %esp

            movl %esi, %eax             
            incl %eax                   #return i+1 (este paso y el anterior)
            
            popl %ebx
            popl %edi
            popl %esi
            movl %ebp, %esp
            popl %ebp
            ret



            movb (%edx, %eax), %ebx     #v[j].c
            movb %ebx, 12(%edx, %eax)   #v[j+1].c = v[j].c

            movl 4(%edx, %eax), %ebx    #v[j].k
            movl %eax, 16(%edx, %eax)   #v[j+1].k = v[j].k

            movl 8(%edx, %eax), %ebx    #v[j].m
            movl %ebx, 20(%edx, %eax)   #v[j+1].m = v[j].m
            