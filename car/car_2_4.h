#ifndef CAR_2_4_H
#define CAR_2_4_H

#include "macro.h"
#include "list1.h"

class CAR_2_4
{
public:
    // условие не понятно, т.к. в примере 10 стоит левее 5,
    // хотя это запрещено
    template<class T>
    static void perm(List1<T> &list, const T &val)
    {
        auto p1 = list.head;
        Node1<T> *px = nullptr;
        while (p1) {
            if (p1->value == val && !px) {
                px = p1;
                break;
            }
            p1 = p1->next;
        }
        if (!px) // не будем решать, допустим, он есть
            return;
        Node1<T> *prev = nullptr;
        p1 = list.head;
        bool atLeft = true;
        while (p1) {
            if (p1 == px) {
                atLeft = false;
            }
            if (prev && p1 != px) {
                if (p1->value == val) {
                    // ставим после px и меняем px
                    auto next = p1->next;
                    prev->next = next;
                    auto pn = px->next;
                    px->next = p1;
                    p1->next = pn;
                    px = p1;
                } else if (p1->value < val) {
                    // вырезать, вставить в начало
                    if (!atLeft) {
                        auto next = p1->next;
                        prev->next = next;
                        p1->next = list.head;
                        list.head = p1;
                        p1 = next;
                        continue;
                    }
                } else if (p1->value > val) {
                    // вырезать, вставить в конец
                    if (atLeft) {
                        auto next = p1->next;
                        prev->next = next;
                        p1->next = nullptr;
                        list.tail->next = p1;
                        list.tail = p1;
                        p1 = next;
                        continue;
                    }
                }
            }
            prev = p1;
            p1 = p1->next;
        }
    }

    static void test()
    {
        List1<int> list;
        list.add(3);
        list.add(5);
        list.add(8);
        list.add(5);
        list.add(10);
        list.add(2);
        list.add(1);
        perm(list, 5);
        ASSERT(list[0]->value == 1);
        ASSERT(list[1]->value == 2);
        ASSERT(list[2]->value == 3);
        ASSERT(list[3]->value == 5);
        ASSERT(list[4]->value == 5);
        ASSERT(list[5]->value == 8);
        ASSERT(list[6]->value == 10);
    }
};

#endif // CAR_2_4_H
