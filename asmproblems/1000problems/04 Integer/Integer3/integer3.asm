; Integer3 ° . Дан размер файла в байтах. Используя операцию деления нацело,
; найти количество полных килобайтов, которые занимает данный файл
; (1 килобайт = 1024 байта).
;
; Вывод:
; 1073741824 B = 1048576 KB
extern  printf
section .data
        KB      equ     1024
        Bytes   dq      1073741824; = 1024×1024×1024
        strFormat       db      "%d B = %d KB",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; здесь достаточно сдвинуть на 10
        ; mov     rax, [Bytes]
        ; shr     rax, 10
        
        ; но нужно поупражняться в делении нацело, поэтому использую idiv
        mov     rax, [Bytes]
        cqo
        mov     rbx, KB
        idiv    rbx
        
        mov     rdi, strFormat
        mov     rsi, [Bytes]
        mov     rdx, rax
        mov     rax, 0          ; кол-во вещественных
        call    printf
        
        leave
        ret
