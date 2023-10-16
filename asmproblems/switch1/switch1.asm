        ; КАК ЗАНЕСТИ АДРЕСА МЕТОК В КАКОЙ-НИБУДЬ МАССИВ???
extern  printf
section .data
        
section .bss
section .text
        global  main
        
main:
        push    rbp
        mov     rbp, rsp
        
        ; простой переход
        mov     rax, 1          ; switch
        cmp     rax, 0
        je      case_0
        cmp     rax, 1
        je      case_1
        jmp     default_1
case_0:
        jmp     done
case_1:
        jmp     done
default_1:
        jmp     done
done:
        ; сложный - подобие B-дерева
        ; ветки упорядочены по возрастанию
        ; пусть 0...1000, x=453
        ; 1. 401_500
        ; 2. 441_450
        ; 3. 441
        ; 4. 442
        ; 5. 443
        mov     rax, 450
        cmp     rax, 100
        jle     case_0_100
        cmp     rax, 200
        jle     case_101_200
        jmp     default_0
case_0_100:
        ; вложенный выбор
        cmp     rax, 10
        je      case_0_10
        cmp     rax, 20
        je      case_11_20
        jmp     default_0
        case_0_10:
                jmp     default_0
        case_11_20:
                jmp     default_0
                
case_101_200:
default_0:
done_0:
        leave
        ret
