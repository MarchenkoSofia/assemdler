;Вычислить x=arctan(2^b)−a
;ПОЛИЗ: 2 b ^ arctan a -

section .rodata
  a: dd 0.5
  b: dd 5.0
 ; b: dd 0.5
  two: dd 2.0
  one: dd 1.0
  
section .bss
  x: resd 1
section .text
  global main
main:
  mov rbp, rsp ; for correct debugging
  
  ;для дробной степени
  ;  fld dword [b]     
  ;  f2xm1      ;2^x = (2^x-1)+1 = F2XM1(x)+1
  ;  fld dword [one]
  ;  fadd   
  
        
  ;для целой степени
  fld dword [b]
  fld1  
  fscale
             
  fld1                      
  fpatan             
  
  fld dword [a]   
  fsub               

  fstp dword [x]   

  ret              
