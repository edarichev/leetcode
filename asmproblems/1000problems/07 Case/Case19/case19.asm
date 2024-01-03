; Case19 . В восточном календаре принят 60-летний цикл, состоящий из 12-летних 
; подциклов, обозначаемых названиями цвета: зеленый, красный, желтый, белый и черный. 
; В каждом подцикле годы носят названия животных:
; крысы, коровы, тигра, зайца, дракона, змеи, лошади, овцы, обезьяны, 
; курицы, собаки и свиньи. По номеру года определить его название, если 1984
; год — начало цикла: «год зеленой крысы».
;
; Вывод:
; 2023: год чёрного зайца
extern  printf
extern  strcat
section .data
        Y               dq      2023
        N               equ     1984
        
        s_male          db      "го",0
        s_female        db      "й",0
        
        s_color1        db      "зелёно",0
        s_color2        db      "красно",0
        s_color3        db      "жёлто",0
        s_color4        db      "бело",0
        s_color5        db      "чёрно",0       ; он же синий, вода
        
        color_names     dq      s_color1, s_color2, s_color3, s_color4, s_color5
        
        s_tier1         db      "крысы",0
        s_tier2         db      "коровы",0
        s_tier3         db      "тигра",0
        s_tier4         db      "зайца",0
        s_tier5         db      "дракона",0
        s_tier6         db      "змеи",0
        s_tier7         db      "лошади",0
        s_tier8         db      "овцы",0
        s_tier9         db      "обезьяны",0
        s_tier10        db      "курицы",0
        s_tier11        db      "собаки",0
        s_tier12        db      "свиньи",0
        
        tiere_names     dq      s_tier1, s_tier2, s_tier3, s_tier4, s_tier5, s_tier6
                        dq      s_tier7, s_tier8, s_tier9, s_tier10, s_tier11, s_tier12
        genders         equ     000000011100b   ; 12 бит: 1 - мужской, 0 - женский
        
        strFormat       db      "%d: год %s%s %s",10,0      ; год (зелёно)(й|го) (крысы)
        strError        db      "Не поддерживается",10,0
        
section .bss
        
section .text
        global  main
main:
        push    rbp
        mov     rbp, rsp
        mov     rax, [Y]
        mov     rsi, rax        ; сохраним, т.к. делить 2 раза, и совпадает с параметром printf
        sub     rax, N
        mov     rcx, rax

        cmp     rax, 0
        jl      notsupported    ; допустим, только позднее N
        cdq
        mov     rbx, 12
        idiv    rbx
        ; rdx - остаток, он же смещение в 12-летнем цикле, животное
        mov     r8, rdx
        mov     rax, rcx
        cdq
        mov     rbx, 5
        idiv    rbx
        ; rdx - цвет от 0, совпадает с парамером printf
        ; проверим пол - это бит
        mov     rax, genders
        bt      rax, rdx
        jc      set_male
        mov     rcx, s_female
        jmp     done
set_male:
        mov     rcx, s_male
        jmp     done

notsupported:
        mov     rdi, strError
        call    printf
        jmp     exit
done:
        ; вывод
        mov     rdi, strFormat
        ; rsi   - год
        ; rdx   - цвет
        lea     rax, color_names
        mov     rdx, [rax + rdx * 8]
        ; rcx   - окончание (м./ж.), выше выбрано
        ; r8    - животное
        lea     rax, tiere_names
        mov     r8, [rax + r8 * 8]
        mov     rax, 0
        call    printf
exit:
        leave
        ret
