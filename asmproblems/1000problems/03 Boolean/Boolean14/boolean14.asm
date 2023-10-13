;Boolean14 . Даны три целых числа: A , B , C . Проверить истинность высказывания: 
; «Ровно одно из чисел A , B , C положительное».
;
; Вывод:
; True (4, -2, -1)
; False (-2, -3, -1)
extern  printf
section .data
        A               equ     4
        B               equ     2
        C               equ     -1
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; в rax сделаем счётчик и проверим: если число положительно, то увеличим на 1
        ; в конце в нём должно быть ровно 1
        xor     rax, rax
        mov     rbx, A
        ; делать будем хитро: арифметически сдвинем вправо так, чтобы оставить старший бит
        ; тогда мы избежим меток и переходов
        shr     rbx, 63
        add     rax, rbx
        
        mov     rbx, B
        shr     rbx, 63
        add     rax, rbx
        
        mov     rbx, C
        shr     rbx, 63
        add     rax, rbx
        
        cmp     rax, 2          ; 2, т.к. чисел 3, и 2 единицы старших битов отрицательных чисел в сумме дадут 2
        je      done            ; здесь и так будет 1, т.е. true
        xor     rax, rax        ; иначе поставим false
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
