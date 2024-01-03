#ifndef CAR_3_4_H
#define CAR_3_4_H

#include "macro.h"

#include <stack>
#include <queue>

class CAR_3_4
{
public:

    template<typename T>
    class MyQueue
    {
        std::stack<T> s1;
        std::stack<T> s2;
    public:
        void push(T v)
        {
            while (!s2.empty()) {
                // возвращаем всё в s1
                s1.push(s2.top());
                s2.pop();
            }
            s1.push(v);
        }

        void pop()
        {
            // чтобы не перекидывать, оставляем s2 до первой операции push
            if (!s2.empty()) {
                s2.pop();
                return;
            }
            while (!s1.empty()) {
                s2.push(s1.top());
                s1.pop();
            }
            s1.pop();
        }

        T &front()
        {
            if (!s2.empty())
                return s2.top();
            while (!s1.empty()) {
                s2.push(s1.top());
                s1.pop();
            }
            return s2.top();
        }
    };

    static void test()
    {
        MyQueue<int> q1;
        q1.push(1);
        q1.push(2);
        q1.push(3);
        q1.push(4);
        q1.push(5);
        ASSERT(q1.front() == 1);
        q1.pop();
        ASSERT(q1.front() == 2);
        q1.push(6);
        q1.push(7);
        ASSERT(q1.front() == 2);
        q1.pop();
        ASSERT(q1.front() == 3);
        q1.pop();
        ASSERT(q1.front() == 4);
        q1.pop();
        ASSERT(q1.front() == 5);
        q1.pop();
        ASSERT(q1.front() == 6);
        q1.pop();
        ASSERT(q1.front() == 7);
        q1.pop();
    }
};

#endif // CAR_3_4_H
