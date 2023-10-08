#ifndef CAR_2_8_H
#define CAR_2_8_H

#include "macro.h"
#include "list1.h"

class CAR_2_8
{
public:

    template<class T>
    Node1<T> *findNode(List1<T> &list)
    {
        return nullptr;
    }

    static void test()
    {
        List1<char> list1;
        list1.add('A');
        list1.add('B');
        auto c = list1.add('C');
        list1.add('D');
        auto e = list1.add('E');
        e->next = c;

        e->next = nullptr;//разорвать, чтобы всё удалить
    }
};

#endif // CAR_2_8_H
