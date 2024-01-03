; Begin18. Даны три точки A , B , C на числовой оси. Точка C расположена между
; точками A и B . Найти произведение длин отрезков AC и BC .
;
; Вывод:
; a=-9, b=-4, c=1, |ac|=10, |bc|=5, |ac|*|bc|=50
extern  printf
section .data
        a       dq      -9
        b       dq      -4
        c       dq      1
        strFormat       db      "a=%d, b=%d, c=%d, |ac|=%d, |bc|=%d, |ac|*|bc|=%d",10,0
section .bss
        ac      resq    1       ; переменная для |ac|
        bc      resq    1       ; переменная для |bc|
        acbc    resq    1       ; |ac|*|bc|
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, [c]
        
        mov     rax, rcx
        sub     rax, [a]
        mov     [ac], rax       ; rax == ac
        
        mov     rbx, rcx
        sub     rbx, [b]
        mov     [bc], rbx       ; rbx == bc
        
        imul    rax, rbx
        mov     [acbc], rax
        
        mov     rax, 0          ; кол-во вещественных чисел
        mov     rdi, strFormat
        mov     rsi, [a]
        mov     rdx, [b]
        mov     rcx, [c]
        mov     r8, [ac]
        mov     r9, [bc]
        push    qword [acbc]
        
        call    printf
        
        leave
        ret
