#ifndef STACKS_H
#define STACKS_H

#include <vector>
#include <iostream>

// класс стека на массиве
class ArrStack
{
    const int N = 200;
    std::vector<int> _arr;
    int _lo = 0; // включительно
    int _hi = N - 1; // включительно
    int _sp = 0; // sp по lowerBound до upperBound
public:
    ArrStack()
    {
        _arr.resize(N);
    }

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
#endif // STACKS_H
