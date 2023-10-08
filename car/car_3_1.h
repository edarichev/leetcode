#ifndef CAR_3_1_H
#define CAR_3_1_H

#include "macro.h"
#include <vector>

class CAR_3_1
{
public:

    class ArrStack
    {
        // 0...5, 6...9, 10....15
        std::vector<int> &_arr;
        int _lo = -1; // включительно
        int _hi = -1; // включительно
        int _sp = -1; // sp по lowerBound до upperBound
    public:
        ArrStack(std::vector<int> &a, int lowerBound, int upperBound)
            : _arr(a), _lo(lowerBound), _hi(upperBound), _sp(lowerBound - 1) {}

        // вернуть сверху
        int peek()
        {
            if (_sp < _lo)
                throw;
            return _arr[_sp];
        }

        int pop()
        {
            if (_sp < _lo)
                throw;
            return _arr[_sp--];
        }

        void push(int v)
        {
            if (_sp + 1 > _hi)
                throw;
            _arr[++_sp] = v;
        }

        void print()
        {
            for (int i = _sp; i >= _lo; i--) {
                std::cout << _arr[i] << " ";
            }
            std::cout << "\n";
        }
    };

    static void test()
    {
        std::vector<int> a(16);
        ArrStack s1(a, 0, 5);
        ArrStack s2(a, 6, 9);
        ArrStack s3(a, 10, 15);
        s1.push(1);
        s1.push(2);
        s1.push(3);
        s1.push(4);
        s1.push(5);
        s1.print();
        std::cout << "pop" << s1.pop() << "\n";
        s1.print();
        s2.push(1);
        s2.push(2);
        s2.print();
        s3.push(1);
        s3.push(2);
        s3.print();
    }
};

#endif // CAR_3_1_H
