%include "io64.inc"

section .rodata
      x: dd 0.2

section .text
      global main
main:
      mov rbp, rsp; for correct debugging

      movss xmm0, dword [x]  ; xmm0 = x
      
      movss xmm6, xmm0     ; xmm6 = x (result)
      
      mov eax, 1
      cvtsi2ss xmm1, eax    ; xmm1 = 1
      mov eax, 2
      cvtsi2ss xmm2, eax    ; xmm2 = 2
      mov eax, -1
      cvtsi2ss xmm3, eax    ; xmm3 = -1
      
      mov ecx, 2            ; ecx = n (counter)
      movss xmm5, xmm0      ; xmm5 = previous memory element
      
     
      mulss xmm0, xmm0      ; xmm0 = x^2
      

.start:

      mulss xmm5, xmm3     ; xmm5 *= -1
      mulss xmm5, xmm0     ; xmm5 *= x^2
    
     
      cvtsi2ss xmm4, ecx   ; xmm4 = n
      mulss xmm4, xmm2     ; xmm4 *= 2
      subss xmm4, xmm2     ; xmm4 -= 2
    
     
      divss xmm5, xmm4     ; xmm5 /= (2n-2)
    
    
      addss xmm4, xmm1     ; xmm4 += 1
      divss xmm5, xmm4     ; xmm5 /= (2n-1)
    
      
      addss xmm6, xmm5     ; xmm6 += xmm5

 
      inc ecx              ; ecx += 1

 
      cmp ecx, 4
      je .end
      
      jmp .start

.end:
 
      ret
