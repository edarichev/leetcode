; Boolean7 ° . Даны три целых числа: A , B , C . Проверить истинность высказывания: 
; «Число B находится между числами A и C ».
;
; Вывод:
; False (при A=1, B=1, C=-3)
; суть в следующем: "между" - это может быть и чему-то равно
; т.е.: A <= B <= C -> A <= B && B <= C
extern  printf
section .data
        A               equ     1
        B               equ     1
        C               equ     -3      ; для false
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; A <= B && B <= C
        xor     rax, rax        ; ставим false изначально
        mov     rbx, A
        mov     rcx, B
        cmp     rbx, rcx
        jg      done            ; A > B, -> false
        mov     rbx, C
        cmp     rcx, rbx        ; rcx==B, rbx==C
        jg      done
        mov     rax, 1          ; true
done:
        ; вывод: выбираем строку True/False по значению rax
        test    rax, rax
        jnz     setTrue
        mov     rsi, strFalse
        jmp     setFormat
setTrue:
        mov     rsi, strTrue
setFormat:
        mov     rdi, strFormat
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
