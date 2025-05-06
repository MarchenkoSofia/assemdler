section .rodata
   
section .text
    extern access4
global main
main:
    sub rsp, 32
    mov r8, 0x7FC00000
   
    mov ecx, 0x18A0      
    mov edx, 0x00A0 
    
    call access4
    
    add rsp, 32
    ret
    
    
    
  