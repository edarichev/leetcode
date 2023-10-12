; Integer29 ° . Даны целые положительные числа A , B , C . На прямоугольнике 
; размера A × B размещено максимально возможное количество квадратов со
; стороной C (без наложений). Найти количество квадратов, размещенных
; на прямоугольнике, а также площадь незанятой части прямоугольника.
;
; Вывод:
; A = 29, B = 37, C = 7 -> N = 20, S = 93
extern  printf
section .data
        A       equ     29
        B       equ     37
        C       equ     7
        strFormat      db      "A = %d, B = %d, C = %d -> N = %d, S = %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp

        mov     ax, A
        cwd
        mov     cx, C           ; пусть C в CX
        div    cx
        movsx   r8, ax          ; r8 = сколько влезет по стороне A
        
        mov     ax, B
        cwd
        div    cx
        movsx   r9, ax          ; r9 = сколько влезет по стороне B
        
        imul    r8, r9          ; r8 = по A * по B = всего квадратов
        mov     r9, r8
        imul    r9, C           ; площадь занятой части
        imul    r9, C           ; ещё раз, т.к. обе стороны по C
        
        mov     rax, A
        imul    rax, B          ; rax - площадь A*B
        
        sub     rax, r9         ; площадь незанятой части
        
        ; выводим
        mov     rdi, strFormat
        mov     rsi, A
        mov     rdx, B
        mov     rcx, C
        ; r8 есть
        mov     r9, rax
        mov     rax, 0          ; кол-во вещественных
        call    printf
        leave
        ret
