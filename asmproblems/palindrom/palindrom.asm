; Является ли слово палиндромом?
; Вывод:
; The word [saippuakauppias] is a palindrom
; The word [Apfel] is not a palindrom

extern  printf
section .data
    strText1    db  "saippuakauppias",0
    nLength1    equ  $-strText1-1
    strText2    db  "Apfel",0
    nLength2    equ  $-strText2-1
    strFormatYes        db  "The word [%s] is a palindrom",10,0
    strFormatNo         db  "The word [%s] is not a palindrom",10,0
section .bss
section .text
    global main
main:
        push    rbp
        mov     rbp, rsp

        mov     rdi, strText1
        mov     rsi, nLength1
        call    ispalindrom
        
        mov     rdi, rax
        mov     rsi, strText1
        call    printinfo
        
        mov     rdi, strText2
        mov     rsi, nLength2
        call    ispalindrom
        
        mov     rdi, rax
        mov     rsi, strText2
        call    printinfo
        
        leave
        ret
printinfo:
        ; Выводит сообщение, является ли слово палиндромом
        ; Input:
        ;       rdi - 1 - да, 0 - нет
        ;       rsi - строка
        push    rbp
        mov     rbp, rsp
        cmp     rdi, 0
        je      .not_palindrom
        mov     rdi, strFormatYes
        jmp     .lbprint
.not_palindrom:
        mov     rdi, strFormatNo
.lbprint:
        ; rsi уже есть - в параметре
        call    printf
        
        leave
        ret

ispalindrom:
        ; Является ли слово палиндромом?
        ; Input:
        ;       rdi - адрес слова
        ;       rsi - длина слова
        ; Returns:
        ;       rax - 1 - да, 0 - нет
        push    rbp
        mov     rbp, rsp
        
        xor     rax, rax        ; false
        mov     rcx, rsi        ; счётчик, будем идти от центра к началу
        shr     rcx, 1          ; делим на 2, до середины слова
        jnz     .work
        leave                   ; длина == 0 или 1, выходим, false
        ret
        
.work:
        dec     rcx             ; т.к. с 0, напр. len=2, cx=2/2=1, от левый центра это 1 (от 0 - это 0), т.е. rcx-1, а правый == 1
.loop:
        mov     rbx, rdi        ; левая буква - rbx
        add     rbx, rcx
        mov     bl, [rbx]
        mov     rdx, rdi        ; правая буква - rdx
        add     rdx, rsi
        dec     rdx             ; т.к. с 0
        sub     rdx, rcx
        mov     dl, [rdx]

        cmp     bl, dl        ; буквы должны быть равны
        jne     .exit
        cmp     rcx, 0
        jz      .ok             ; букв больше нет, это перевёртыш
        dec     rcx
        jmp     .loop
.ok:
        mov     al, 1           ; true
.exit:
        leave
        ret


