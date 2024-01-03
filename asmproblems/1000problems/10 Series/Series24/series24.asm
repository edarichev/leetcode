; Series24 . Дано целое число N и набор из N целых чисел, содержащий по
; крайней мере два нуля. Вывести сумму чисел из данного набора, расположенных
; между последними двумя нулями (если последние нули идут подряд, то вывести 0).
;
; Вывод:
; Sum=12

extern  printf
section .data
        series1         dq      1,2,3,0,1,2,0,3,4,5,0,34
        cend            dq      $
        N               equ     12
        strFormat       db      "Sum=%d",10,0
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rcx, N
        mov     rdi, [cend]
        sub     rdi, 8
        xor     rax, rax                ; признак: 0 - первый 0 не найден
        xor     rdx, rdx                ; сумма
loop_i:
        test    rcx, rcx
        jz      done
        mov     rbx, qword [rdi]
        test    rbx, rbx
        jz      checkZero
        ; иначе - если в rax 0, то ничего не делаем
        test    rax, rax
        jz      next
        ; иначе - суммируем
        add     rdx, rbx
        jmp     next
checkZero:
        test    rax, rax
        jnz     done            ; это уже второй 0, поэтому выходим
        mov     rax, 1          ; ставим флаг, что нашли первый 0
next:
        sub     rdi, 8
        dec     rcx
        jmp     loop_i
done:
        mov     rdi, strFormat
        mov     rsi, rdx
        call    printf
        leave
        ret
