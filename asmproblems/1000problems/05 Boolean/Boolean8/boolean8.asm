; Boolean8 . Даны два целых числа: A , B . Проверить истинность высказывания:
; «Каждое из чисел A и B нечетное».
;
; Вывод:
; False (4, 2)
; True (1, 3)
extern  printf
section .data
        A               equ     1
        B               equ     3
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        xor     rax, rax        ; ставим false изначально
        ; нечётное - последний бит равен 1
        ; два варианта: через bittest и маска == 1
        mov     rbx, A
        xor     rdx, rdx        ; ставим 0, т.к. нужен младший бит
        bt      rbx, rdx
        jnc     done            ; CF==0? тогда false
        ; а второй метод - через маску:
        mov     rbx, B
        ; нужен AND, чтобы изменить rbx, или test, чтобы не менять, но установить флаги:
        test    rbx, 1          ; 1 - младший бит, установка ZF, если не 1
        jz      done
        mov     rax, 1
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
