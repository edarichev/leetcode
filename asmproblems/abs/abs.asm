extern  printf
section .data
        X       dq      1.0
        fmt     db      "%d",10,0
section .bss
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rax, -12345
        mov     rbx, rax
        neg     rax
        cmovl   rax, rbx
        
        mov     rdi, fmt
        mov     rsi, rax
        call    printf
        
        leave
        ret
