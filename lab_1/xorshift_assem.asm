section .data
    prompt db "Введите начальное число: ", 0
    output_format db "%llu", 10, 0  ; Используем %llu для 64-битных чисел
    header db "Сгенерированные числа:", 10, 0

section .bss
    seed resq 1                     ; Переменная для хранения начального числа (64 бита)
    state resq 4                    ; Состояние генератора (4 слова по 64 бита)

section .text
    extern printf, scanf
    global main

main:
    ; Запрос начального числа
    push prompt
    call printf
    add rsp, 8                      ; Очищаем стек

    ; Чтение числа в seed
    lea rdi, [seed]                 ; Указатель на seed
    lea rsi, [output_format]        ; Формат вывода
    call scanf
    add rsp, 16                     ; Очищаем стек

    ; Инициализация генератора
    mov rax, [seed]                 ; Загружаем seed в rax
    call xorshift128_init

    ; Печать заголовка
    push header
    call printf
    add rsp, 8                      ; Очищаем стек

    ; Генерация и вывод 100 чисел
    mov rcx, 100                    ; Счетчик для 100 чисел

generate_numbers:
    call xorshift128                ; Генерация числа
    push rax                        ; Сохранение результата
    lea rsi, [output_format]        ; Формат вывода
    call printf                     ; Печать числа
    add rsp, 8                      ; Очищаем стек

    loop generate_numbers            ; Повторяем 100 раз

    xor rax, rax                    ; Возвращаем 0
    ret

; Функция инициализации состояния генератора
xorshift128_init:
    mov [state], rax                ; state[0] = seed
    mov rbx, rax                    ; rbx = seed
    xor rbx, 0x5DEECE66D            ; state[1] = seed ^ 0x5DEECE66D
    mov [state + 8], rbx            ; state[1] = rbx

    mov rbx, rax                    ; rbx = seed
    xor rbx, 0xB16B00B5            ; state[2] = seed ^ 0xB16B00B5
    mov [state + 16], rbx           ; state[2] = rbx

    mov rbx, rax                    ; rbx = seed
    xor rbx, 0xDEADBEEF            ; state[3] = seed ^ 0xDEADBEEF
    mov [state + 24], rbx           ; state[3] = rbx

    ret

; Функция генерации случайного числа
xorshift128:
    mov rax, [state + 24]           ; t = state[3]

    mov rbx, [state]                ; s = state[0]
    mov [state + 24], [state + 16]  ; state[3] = state[2]
    mov [state + 16], [state + 8]   ; state[2] = state[1]
    mov [state + 8], rbx             ; state[1] = s

    shl rax, 11                      ; t << 11
    xor rax, [state + 24]           ; t ^= state[3]
    
    shr rax, 8                       ; t >> 8
    xor rax, [state + 24]           ; t ^= state[3]

    mov rbx, [state]                ; s = state[0]
    xor rax, rbx                    ; t ^= s
    
    shr rbx, 19                      ; s >> 19
    xor rax, rbx                    ; t ^= (s >> 19)

    mov [state], rax                ; state[0] = t
    
    ret                              ; Возврат значения в rax
