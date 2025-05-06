; 𝑦 ≥ 𝑙𝑔^2(𝑠𝑖𝑛 (𝑥) + 𝑎)
;Проверить, что заданная точка (x, y) удовлетворяет
;условию 𝑦 ≥ 𝑙𝑔^2(𝑠𝑖𝑛 (𝑥) + 𝑎)
;Замечание: правая часть не определена на ℝ при 𝑥 > 𝑎.
;ПОЛИЗ правой части: 𝑥 sin a + log2 log2(10) / 2 ^

;Код для x87:

%include "io64.inc"
section .rodata
    a: dd 20.0
    x: dd 30.0
    y: dd 0.1
section .text
    global main
main:
    mov rbp, rsp; for correct debugging st0 = x
    
    fld1
    fld dword[x] 
    fsin
    fld dword[a] 
    fadd

   
    fyl2x
    
    fldl2t
    
    fdiv

    
    fld st0
    
    fmul
    
    fld dword[y]  

    fcomip st0, st1             
   
    jae true_message           

    false_message:
        PRINT_STRING "No"   
    jmp end

    true_message:
        PRINT_STRING "Yes"     

end:
    finit
    ret