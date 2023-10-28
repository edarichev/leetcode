; Boolean28 . Даны числа x , y . Проверить истинность высказывания: 
; «Точка с координатами ( x , y ) лежит в первой или третьей координатной четверти».
;
; Вывод:
; True (5, 1)
; False (-2, 1)
extern  printf
section .data
        x               equ     5
        y               equ     1
        strTrue         db      "True",0
        strFalse        db      "False",0
        strFormat       db      "%s",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        ; здесь не нужны вещественные числа, т.к. корни не ищем
        xor     rax, rax        ; <- false
        ; здесь x и y должны быть одного знака
        ; можно ничего не делать, а лишь сдвинуть на 63 вправо x и y и сравнить 
        ; ставшие младшими биты, они должны быть равны
        mov     rbx, x
        shr     rbx, 63         ; знаковый бит x теперь стал младшим
        mov     rcx, y
        shr     rcx, 63         ; знаковый бит y теперь стал младшим
        xor     rbx, rcx        ; и если биты одинаковы, то
        jnz     out             ; xor должен дать 0 и установить ZF
        mov     rax, 1
out:
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
