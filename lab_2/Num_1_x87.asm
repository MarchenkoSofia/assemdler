; Программа: Округление вещественного числа вниз для х87
%include "io64.inc"
section .rodata:
  x: dd 9.99

section .bss
  result: resd 1

section .text
  global main

main:
  fld dword[x]
  sub rsp, 8   
  fstcw [rsp]   
  mov al, [rsp+1] 
  and al,  0x08  
  or al, 4   
  mov [rsp+1], al 
  fldcw [rsp]  
  add rsp, 8   
  fist dword [result]
           
  mov eax, [result] 
  PRINT_DEC 4, eax   

  xor eax, eax  
  ret      
