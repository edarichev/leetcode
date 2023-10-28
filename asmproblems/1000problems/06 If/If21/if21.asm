; If21 . Даны целочисленные координаты точки на плоскости. Если точка совпадает 
; с началом координат, то вывести 0. Если точка не совпадает с началом
; координат, но лежит на оси OX или OY , то вывести соответственно 1 или 2.
; Если точка не лежит на координатных осях, то вывести 3.
;
; Вывод:
; 0, 0 -> 0
; 3, 0 -> 1
; 0, 4 -> 2
; 3, 5 -> 3
extern  printf

section .data
        X               dq      3
        Y               dq      4
        strFormat       db      "%d, %d -> %d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        ; в качестве результата используем rcx (в выводе будет использован rcx)
        mov     rax, [X]
        mov     rbx, [Y]
        test    rax, rax        ; x == 0?
        jnz     checkY
        test    rbx, rbx        ; тут x==0, а y==0?
        jnz     atY             ; нет, x==0, y!=0
        xor     rcx, rcx        ; x==0 && y==0 -> 0
        jmp     done
atY:                            ; x==0, y!=0
        mov     rcx, 2
        jmp     done
checkY:                         ; в этой ветке x!=0
        test    rbx, rbx
        jnz     atFree          ; x!=0 && y!=0
        mov     rcx, 1          ; x!=0 && y==0 -> OX
        jmp     done
atFree:
        mov     rcx, 3
done:
        ; выводим
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, [X]
        mov     rdx, [Y]
        call    printf
        leave
        ret
