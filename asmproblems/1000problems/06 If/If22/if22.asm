; 
;
; Вывод:
; 1, 1 -> 1
; -3, 2 -> 2
; -4, -4 -> 3
; 3, -5 -> 4
extern  printf

section .data
        X               dq      3
        Y               dq      -4
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
        
        cmp     rax, 0
        jl      check2_3        ; x<0? 2|3 четверти
        ; здесь 1 или 4
        cmp     rbx, 0
        jl      set4            ; y<0?
        mov     rcx, 1          ; x>0 && y>0
        jmp     done
set4:
        mov     rcx, 4          ; x>0 && y<0
        jmp     done
check2_3:
        cmp     rbx, 0
        jl      set3            ; y<0?
        mov     rcx, 2          ; x<0 && y>0
        jmp     done
set3:
        mov     rcx, 3          ; x<0 && y<0
done:
        ; выводим
        mov     rax, 0          ; кол-во вещественных
        mov     rdi, strFormat
        mov     rsi, [X]
        mov     rdx, [Y]
        call    printf
        leave
        ret
