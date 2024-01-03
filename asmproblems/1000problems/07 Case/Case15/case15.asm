; Case15 . Мастям игральных карт присвоены порядковые номера: 1 — пики,
; 2 — трефы, 3 — бубны, 4 — червы. Достоинству карт, старших десятки,
; присвоены номера: 11 — валет, 12 — дама, 13 — король, 14 — туз. Даны
; два целых числа: N — достоинство (6 ≤ N ≤ 14) и M — масть карты
; (1 ≤ M ≤ 4). Вывести название соответствующей карты вида «шестерка бубен», 
; «дама червей», «туз треф» и т. п.
;
; Вывод:
; семёрка треф
extern  printf
section .data
        N               dq      7 ; 6 ≤ N ≤ 14
        M               dq      2 ; (1 ≤ M ≤ 4)
        sname6          db      "шестёрка",0
        sname7          db      "семёрка",0
        sname8          db      "восьмёрка",0
        sname9          db      "девятка",0
        sname10         db      "десятка",0
        sname11         db      "валет",0
        sname12         db      "дама",0
        sname13         db      "король",0
        sname14         db      "туз",0
        
        snameP          db      "пик",0
        snameT          db      "треф",0
        snameB          db      "бубен",0
        snameC          db      "червей",0
        
        strFormat       db      "%s %s",10,0
        strError        db      "Не поддерживается",10,0
        
        names           dq      snameP, snameT, snameB, snameC
        numbers         dq      sname6, sname7, sname8, sname9, sname10,
                        dq      sname11, sname12, sname13, sname14
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rax, [N]
        cmp     rax, 6
        jb      case_default
        cmp     rax, 14
        ja      case_default
        sub     rax, 6
        mov     rbx, [M]
        cmp     rbx, 1
        jb      case_default
        cmp     rbx, 4
        ja      case_default
        ; через switch/case будет просто ужасно, решу через массив
        ; rsi - номер карты (numbers), rdx - масть (names)
        
        lea     rdx, names
        mov     rdx, [rdx + rbx * 8 - 8]
        
        lea     rsi, numbers
        mov     rsi, [rsi + rax * 8]    ; этот с 0 нумеруется
        jmp     done
case_default:
        mov     rdi, strError
        call    printf
        jmp     exit
done:
        mov     rax, 0          ; 0 Вещественных
        mov     rdi, strFormat
        call    printf
exit:
        leave
        ret
