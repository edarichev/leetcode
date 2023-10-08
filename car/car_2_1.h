#ifndef CAR_2_1_H
#define CAR_2_1_H

#include "macro.h"
#include "list1.h"
#include "list2.h"

class CAR_2_1
{
public:

    template<class T>
    static void removeDuplicates(List1<T> &list)
    {
        auto p1 = list.head;
        if (!p1)
            return;
        while (p1) {
            auto p2 = p1->next;
            T v = p1->value;
            while (p2) {
                if (p2->value == v) {
                    auto n = p2->next;
                    list.remove(p2);
                    p2 = n;
                    continue;
                }
                p2 = p2->next;
            }
            p1 = p1->next;
        }
    }

    static void test()
    {
        List1<int> list;
        list.add(1);
        list.add(1);
        list.add(2);
        list.add(2);
        list.add(1);
        list.add(3);

        removeDuplicates(list);
        ASSERT(list.count() == 3);
        ASSERT(list[0]->value == 1);
        ASSERT(list[1]->value == 2);
        ASSERT(list[2]->value == 3);
    }
};

#endif // CAR_2_1_H
