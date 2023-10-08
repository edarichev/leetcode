#ifndef CAR_2_2_H
#define CAR_2_2_H

#include "macro.h"
#include "list1.h"

// либо метод опережающего указателя, либо сначала подсчёт элементов в одном цикле,
// затем проход до (n-k)-го элемента во втором. Разницы почти никакой -
// кол-во проходов одинаково в обоих случаях = (n + (n-k))=2n-k, в втором
// только дополнительная переменная и инкремент.
class CAR_2_2
{
public:

    template<class T>
    static Node1<T> *findMiddle(List1<T> &list)
    {
        // опережающий пускаем со скоростью 2
        auto lookahead = list.head;
        // в случе чётного: так будет правый элемент, если надо вывести левый,
        // то начинаем с nullptr, а в цикле присвоить с проверкой
        // так: if (!cur) cur = list.head;
        auto cur = list.head;
        while (lookahead) {
            lookahead = lookahead->next;
            if (!lookahead)
                break;
            lookahead = lookahead->next;
            cur = cur->next;
        }
        return cur == nullptr ? list.head : cur;
    }

    template<class T>
    static Node1<T> *findFromEnd(List1<T> &list, int iFromEnd)
    {
        // опережающий указатель
        // первый указатель надо пустить вперёд, и когда он пройдёт iFromEnd,
        // запустить второй. Как только последний укажет на nullptr, то второй
        // будет указывать на нужный
        auto lookahead = list.head;
        if (!lookahead)
            return nullptr;
        int n = iFromEnd + 1; // кол-во пропускаемых элементов
        for (int i = 0; i < n - 1; i++) {
            lookahead = lookahead->next;
            if (lookahead == nullptr)
                return nullptr; // если список короче
        }
        // пропускаем n-й:
        lookahead = lookahead->next; // ещё проход, список больше или равен iFromEnd
        auto cur = list.head;
        while (lookahead) {
            cur = cur->next;
            lookahead = lookahead->next;
        }
        return cur;
    }

    static void test()
    {
        List1<int> list;
        list.add(1);
        list.add(2);
        list.add(3);
        list.add(4);
        list.add(5);
        list.add(6);
        int fromEnd = 2; // с конца
        int foundValue = 4;
        ASSERT(findFromEnd(list, fromEnd)->value == foundValue);
        ASSERT(findFromEnd(list, 6) == nullptr);
        ASSERT(findFromEnd(list, 5)->value == 1);
        ASSERT(findFromEnd(list, 0)->value == 6);
        list.add(7);
        ASSERT(findMiddle(list)->value == 4);
    }
};

#endif // CAR_2_2_H
