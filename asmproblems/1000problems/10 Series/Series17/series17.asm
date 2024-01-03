; Series17 ° . Дано вещественное число B , целое число N и набор из N вещественных
; чисел, упорядоченных по возрастанию. Вывести элементы набора
; вместе с числом B , сохраняя упорядоченность выводимых чисел.
;
; Вывод:
; 1,2,3,4,5,6,6.5,7,8,9,10,   (6.5)
; 0.5,1,2,3,4,5,6,7,8,9,10,   (0.5)
; 1,2,3,4,5,6,7,8,9,10,12,    (12.0)

; т.е. по ходу вывода чисел надо вывести число B где-то в середине
extern  printf
section .data
        series1         dq      1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0
        B               dq      12.0
        N               equ     10
        strFormat       db      "%g,",0
        NL              db      10,0
section .bss
        outb            resq    1       ; 1/0 если выведено
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        
        mov     rcx, N
        mov     rsi, series1
        mov     qword [outb], 0         ; флаг 0, что пока число не выведено
        ; можно поделить на 2 части: сначала вывести меньшие числа, затем число, затем продолжить вывод
        ; можно сначала найти индекс, сделать функцию вывода, вызвать её 2 раза
        ; можно сделать один цикл с условием - выводилось ли число
        and     rsp, 0xfffffffffffffff0
loop_i:
        test    rcx, rcx
        jz      done
        
        movq    xmm0, qword [rsi]
        
        movq    xmm1, xmm0
        movq    xmm2, [B]
        cmppd   xmm1, xmm2, 0EH               ; текущее число > B ?
        movq    rbx, xmm1
        test    rbx, rbx
        jz      writeThisNumber                 ; вывести число, оно меньше этого числа
        ; иначе выводим его
        ; мы его уже выводили?
        mov     rax, [outb]
        test    rax, rax
        jnz     writeThisNumber                 ; да, вывели уже
        mov     qword [outb], 1                 ; меняем флаг
        ; выводим число B
        push    rcx
        push    rsi
        sub     rsp, 16
        movq    qword [rsp], xmm0
        mov     rax, 1
        mov     rdi, strFormat
        movsd   xmm0, [B]
        call    printf
        movq    xmm0, qword [rsp]
        add     rsp, 16
        pop     rsi
        pop     rcx
        
writeThisNumber:
        ; выводим текущее число в xmm0
        push    rcx
        push    rsi
        
        mov     rax, 1
        mov     rdi, strFormat
        call    printf
        
        pop     rsi
        pop     rcx
        add     rsi, 8
        dec     rcx
        jmp     loop_i
done:
        ; может быть так, что оно больше всех, тогда мы его не вывели
        mov     rax, [outb]
        test    rax, rax
        jnz     exit                            ; да, вывели уже
        ; выводим число B, стек тут не нужен
        mov     rax, 1
        mov     rdi, strFormat
        movsd   xmm0, [B]
        call    printf
exit:
        mov     rax, 0
        mov     rdi, NL
        call    printf
        
        leave
        ret
