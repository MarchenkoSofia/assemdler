; Программа: Округление вещественного числа вниз
%include "io64.inc" 

section .rodata
    output_msg:  db "Result (rounded down): ", 0
    number: dd 35.9

section .bss
    result: resq 1

section .text
    global main

main:

    movss xmm0, dword[number]
    roundss xmm0, xmm0, 0x1
    cvttss2si eax, xmm0
    mov [result], eax
    
    PRINT_STRING output_msg
    PRINT_DEC 4, result
    
    xor rax, rax
    ret
     
