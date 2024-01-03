extern  printf
section .data
        sideA   dq      3.0
        sideB   dq      4.0
        strFormat       db      "A^2=%g, B^2=%g, C^2=%g",10,0
        strFormatC      db      "C=%g",10,0
        repcount        dq      10000000000
section .bss

section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rcx, [repcount]
.loop:                          ; измерить производительность по сравнинию с sqrt из C
        ; A^2
        movsd   xmm0, qword [sideA]
        mulsd   xmm0, xmm0
        ; B^2
        movsd   xmm1, qword [sideB]
        mulsd   xmm1, xmm1
        ; C^2 = A^2+B^2
        movsd   xmm2, xmm0
        addsd   xmm2, xmm1
        
        ;movsd   xmm3, xmm2      ; сохранить результат, иначе в printf xmm2 испортится
        
        ; вывод: 3^2+4^2=5^2
        ;mov     rax, 3          ; 3 вещественных
        ;mov     rdi, strFormat
        ;call    printf
        
        ; корень из C
        sqrtsd  xmm0, xmm2
        dec     rcx
        jnz     .loop
        mov     rax, 1          ; 1 вещественное
        mov     rdi, strFormatC
        call    printf
        
        leave
        ret
