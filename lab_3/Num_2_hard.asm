section .text
    extern access1        
    global main            
main:
    mov rbp, rsp

    sub rsp, 40 
    
    mov qword[rsp + 8], 1
    lea rdx, [rsp + 8] 
    
    mov ecx, 1
    

    call access1 

    add rsp, 40

    ret
    
    
    ;-l:C:\Users\Sofia\Desktop\assemb\lab_3\hard.a