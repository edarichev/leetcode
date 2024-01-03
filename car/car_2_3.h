#ifndef CAR_2_3_H
#define CAR_2_3_H

#include "macro.h"
#include "list1.h"

class CAR_2_3
{
public:

    template<class T>
    static void removeInternalNode(Node1<T> *node)
    {
        if (!node)
            return;
        // метод копирования из следующего в предыдущий и удаления последнего
        // если в узле требуется освобождение памяти, то сначала удаляем
        // из node, пусть тут только простые типы.
        if (!node->next) {
            throw; // по условию это невозможно
        }
        do { // по условию он не последний
            auto next = node->next;
            node->value = next->value;
            node->next = next->next;
        } while (node->next);
    }

    static void test()
    {
        List1<char> list;
        list.add('a');
        list.add('b');
        auto c = list.add('c');
        list.add('d');
        list.add('e');
        list.add('f');

        list.remove(c);
        ASSERT(list.count() == 5);
    }
};

#endif // CAR_2_3_H
