; If20 . На числовой оси расположены три точки: A , B , C . Определить, какая из
; двух последних точек ( B или C ) расположена ближе к A , и вывести эту точку и ее расстояние от точки A .
;
; Вывод:
; 15, 16, 17 -> 16, 1
extern  printf

section .data
        A               dq      15
        B               dq      16
        C               dq      17
        strFormat       db      "%d, %d, %d -> x=%d, dx=%d",10,0
section .bss
        P               resq    1       ; точка
        delta           resq    1       ; расстояние |A-P|
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; здесь проще сравнить попарно и методом исключения определить индекс
        mov     rax, [A]
        mov     rbx, [B]
        mov     rcx, [C]
        
        ; найдём расстояния: r8 - |A-B|, r9 - |A-C|
        mov     r8, rax
        mov     r9, r8
        
        sub     r8, rbx
        cmp     r8, 0
        jnl     calcAC
        neg     r8
calcAC:
        sub     r9, rcx
        cmp     r9, 0
        jnl     calcPoint
        neg     r9
calcPoint:
        cmp     r8, r9          ; AB, AC
        jg      ACIsGreater     ; AB > AC ?
        mov     [P], rbx        ; C ближе
        mov     [delta], r8     ; delta = |A-B|
        jmp     done
ACIsGreater:                    ; AB > AC
        mov     [P], rcx        ; P <- C
        mov     [delta], r9     ; delta = |A-C|
done:
        ; выводим
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, [A]
        mov     rdx, [B]
        mov     rcx, [C]
        mov     r8,  [P]
        mov     r9,  [delta]
        call    printf
        leave
        ret
