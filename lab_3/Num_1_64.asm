 
section .rodata
    prompt: db "Initial number: ", 0
    output_msg: db "The numbers generated are:", 10, 0
    fmt_input: db "%u", 0
    output: db "%u", 10, 0
    fmt_output: db "%u %u", 10, 0
   

section .bss           


section .text
    global main 
 
extern printf
extern scanf
extern malloc
extern free

main: ;+8
    push rbp
    mov rbp, rsp; for correct debugging
    
    sub rsp, 40+8
    mov rcx, 16
    call malloc
    mov rbx, rax
    
    lea rcx, [rel prompt]
    call printf
    
    lea rcx, [rel fmt_input]
    lea rdx, [rsp + 8]
    call scanf
    mov r14d, [rsp + 8]
      
    lea rcx, [rel output]
    lea rdx, [r14d]
    call printf
        
    lea rcx, [rel output_msg]
    call printf       
    
    mov dword[rbx], r14d     
    mov r15d, r14d
    xor r15d, 1  
    mov dword[rbx + 4], r15d
    mov r15d, r14d
    xor r15d, 2  
    mov dword[rbx + 8], r15d
    mov r15d, r14d
    xor r15d, 3   
    mov dword[rbx + 12], r15d

    
    xor r14d, r14d 
    
    mov r15d, 0           

cycle_start:
    cmp r15d, 100            ; cmp сравнить
    jge if_end              ; jg больше je равно

    mov r11d, [rbx + 12]   
    mov r12d, [rbx]       

    mov r13d, [rbx + 8]   
    mov [rbx + 12], r13d  
    
    mov r13d, [rbx + 4]   
    mov [rbx + 8], r13d   
   
    mov [rbx + 4], r12d   
    
    mov r13d, r11d          
    shl r13d, 11          
    xor r11d, r13d         
    
    mov r13d, r11d          
    shr r13d, 8            
    xor r11d, r13d           
    
    xor r11d, r12d           

    mov r13d, r12d           
    shr r13d, 19            
    xor r11d, r13d          

    mov [rbx], r11d       
   
    lea rcx, [rel fmt_output]
    mov rdx, r15
    mov r8d, [rbx]
    call printf
   
    add r15d, 1
    
    cmp r15d, 100
    je if_end
    
    jmp cycle_start    

if_end:
    
    mov rcx, rbx
    call free
   
    leave
    ret

