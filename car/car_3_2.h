#ifndef CAR_3_2_H
#define CAR_3_2_H

#include "macro.h"

template <class T>
class MinMaxStack
{
public:
    struct SNode {
        T value;
        SNode *next = nullptr;
        T minSubValue;
        SNode(T v, SNode *nextNode) {
            value = v;
            next = nextNode;
        }
        SNode(T v, SNode *nextNode, T minsub) {
            value = v;
            next = nextNode;
            minSubValue = minsub;
        }
    };

    SNode *top = nullptr;

    void push(T v)
    {
        T mins = v;
        if (top)
        {
            if (v < top->value)
                mins = v;
            else
                mins = top->minSubValue;
        }
        SNode *node = new SNode(v, top, mins);
        top = node;
    }

    T pop()
    {
        T ret = top->value;
        auto next = top->next;
        delete top;
        top = next;
        return ret;
    }

    void print()
    {
        MinMaxStack<T> tmp;
        if (!top)
            return;
        while (top) {
            auto v = top->value;
            tmp.push(pop());
            std::cout << v << " ";
        }
        std::cout << "\n";

        while (tmp.top)
            push(tmp.pop());
    }

    T min()
    {
        if (!top)
            throw;
        return top->minSubValue;
    }
};

// можно либо в узле хранить минимальное значение из всех элементов ниже верхнего,
// либо держать параллельно стек из минимумов и извлекать/вставлять в/из при pop/push
class CAR_3_2
{
public:
    static void test()
    {
        MinMaxStack<int> s1;
        s1.push(3);
        ASSERT(s1.min() == 3);
        s1.push(1);
        ASSERT(s1.min() == 1);
        s1.push(2);
        ASSERT(s1.min() == 1);
        s1.push(3);
        ASSERT(s1.min() == 1);
        s1.push(-1);
        ASSERT(s1.min() == -1);
        s1.pop();
        ASSERT(s1.min() == 1);
        //s1.print();
    }
};

#endif // CAR_3_2_H
