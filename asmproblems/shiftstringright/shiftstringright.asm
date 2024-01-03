; Перестановка букв в слове (циклический сдвиг вправо)
%include "../include/memcpy.inc"
extern  printf
section .data
        nShift          equ      3
        strText         db      "mystring",0    ; -> "ingmystr"
        nStrLen         equ     $-strText-1
        strFormat       db      "%s -> %s",10,0
section .bss
        strBuf          resb    nStrLen+1
section .text
        global main
main:
        push    rbp
        mov     rbp, rsp
        
        ; сначала копируем в начало буфера правую часть с nShift-го символа
        mov     rdi, strBuf     ; куда копируем
        mov     rsi, strText    ; откуда: "mystring"
        add     rsi, nStrLen
        mov     rax, nShift
        sub     rsi, nShift     ; учесть обрезку от сдвига: "mystring"->"ing"
        mov     rdx, nShift     ; сколько скопировать
        call    _memcpy         ; копируем правую часть в начало
        
        ; теперь добавить начало исходной строки в конец целевой
        mov     rdi, strBuf     ; куда копируем
        add     rdi, nShift
        mov     rsi, strText
        mov     rdx, nStrLen
        sub     rdx, nShift
        call    _memcpy
        
        mov     rax, strBuf
        add     rax, nStrLen
        xor     rbx, rbx
        mov     [rax], bl       ; завершающий 0
        
        mov     rdi, strFormat
        mov     rsi, strText
        mov     rdx, strBuf
        call    printf
        
        leave
        ret


