#ifndef CAR_3_5_H
#define CAR_3_5_H

#include "macro.h"
#include <stack>
#include <limits>

class CAR_3_5
{
public:
    template<typename T>
    std::enable_if_t<std::is_arithmetic_v<T>, void>
    static sortStack(std::stack<T> &s)
    {
        // целевой стек - временный, его вернём
        // вытащим первый элемент из исходного и запомним в maxv
        // вытаскиваем из tmp все элементы, меньшие maxv
        // и возвращаем их в исходный, таким образом в tmp останутся
        // только те элементы, которые больше maxv
        // заталкиваем в tmp maxv
        // повторяем до исчерпания исходного стека
        // переносим результат в исходный стек
        std::stack<T> tmp;
        while (!s.empty()) {
            T maxv = s.top();
            s.pop();
            while (!tmp.empty() && tmp.top() < maxv) {
                s.push(tmp.top());
                tmp.pop();
            }
            tmp.push(maxv);
        }
        s = std::move(tmp);
    }
    // можно взять стандартный стек и сортировать его
    static void test()
    {
        std::stack<int> s1;
        s1.push(3);
        s1.push(5);
        s1.push(1);
        s1.push(2);
        s1.push(0);
        // 0, 1, 2, 3, 5
        // 0 - пусть сверху
        sortStack(s1);
//        while (!s1.empty()) {
//            std::cout << s1.top() << " ";
//            s1.pop();
//        }
//        std::cout << "\n";
        ASSERT(s1.top() == 0);
        s1.pop();
        ASSERT(s1.top() == 1);
        s1.pop();
        ASSERT(s1.top() == 2);
        s1.pop();
        ASSERT(s1.top() == 3);
        s1.pop();
        ASSERT(s1.top() == 5);
    }
};

#endif // CAR_3_5_H
