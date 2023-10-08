#ifndef CAR_2_7_H
#define CAR_2_7_H

#include "macro.h"
#include "list1.h"

class CAR_2_7
{
public:
    template<class T>
    static Node1<T> *intersection(List1<T> &list1, List1<T> &list2)
    {
        int n1 = list1.count();
        int n2 = list2.count();
        Node1<T> *pa = nullptr;//более длинный
        Node1<T> *pb = nullptr;
        if (n1 > n2) {
            pa = list1.head;
            pb = list2.head;
        } else {
            pb = list1.head;
            pa = list2.head;
        }
        int n = std::min(n1, n2);
        int i = std::max(n1, n2) - n;
        while (i > 0) {
            pa = pa->next;
            i--;
        }
        while (pa && pb) {
            if (pa == pb)
                return pa;
            pa = pa->next;
            pb = pb->next;
        }
        return nullptr;
    }
    static void test()
    {
        List1<int> list1;
        List1<int> list2;
        auto n1 = list1.add(1);
        auto n2 = list1.add(2);
        list1.add(3);
        list1.add(4);
        list2.add(5);
        list2.add(n2);
        ASSERT(intersection(list1, list2) == n2);
        list2.remove(n1);
        list2.detach();
    }
};

#endif // CAR_2_7_H
