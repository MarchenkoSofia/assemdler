section .rodata
    prompt: db "Initial number: ", 0
    fmt_input: db "%u ", 0
    output: db "%u ", 10, 0
    output_msg: db "The numbers generated are: ", 10, 0
    fmt_output: db "%u %u",10, 0
    
extern printf
extern scanf
extern malloc
extern free

section .text
global main
main:    

    push ebp
    mov ebp, esp
    
    sub esp, 4+4
    
    lea eax, [rel prompt]
    mov [esp], eax
    call printf
    

    lea eax, [rel fmt_input]
    mov [esp], eax
    lea eax, [ebp -4]
    mov [esp+4], eax
    call scanf

    mov edi, [ebp -4]
    lea eax, [rel output]
    mov [esp], eax
    lea eax, [edi]
    mov [esp+4], eax
    call printf
    
    add esp, 4
    
    mov eax, 16
    push eax
    call malloc

    
    mov ebx, eax        
    
    mov dword[ebx], edi     
    mov dword[ebx + 4], edi
    xor dword[ebx + 4], 1
    
    mov dword[ebx + 8], edi
    xor dword[ebx + 8], 2
    
    mov dword[ebx + 12], edi
    xor dword[ebx + 12], 3
    
    lea eax, [rel output_msg]
    mov [esp], eax
    call printf
    
    add esp, 8
    
    xor edi, edi

cycle_start: 
    cmp edi, 100         ; cmp сравнить
    jge if_end 
    
    mov esi, [ebx + 12]
    mov edx, [ebx]
    
    mov eax, [ebx + 8]
    mov [ebx + 12], eax
    mov eax, [ebx + 4]
    mov [ebx + 8], eax
    mov [ebx + 4], edx
    
    mov eax, esi
    shl eax, 11
    
    xor esi, eax
    mov eax, esi
    shr eax, 8
    
    xor esi, eax
    xor esi, edx
    mov eax, edx
    shr eax, 19
    xor esi, eax
    
    mov [ebx], esi
    
    sub esp,8+4
    push dword [ebx]
    push edi
    push fmt_output
    call printf
    add esp, 8
    
    add edi, 1
    
    cmp edi, 100
    je if_end
    
    jmp cycle_start 
    
if_end:
    sub esp, 4
    push ebx
    call free
    add esp, 4
    
    leave
    ret
