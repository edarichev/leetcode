#ifndef CIRCULARBUFFER_H
#define CIRCULARBUFFER_H

#include <stddef.h>
#include <iostream>
#include <vector>
#include "../helpers.h"

template <typename T>
class CircularBuffer
{
    std::vector<T> _buffer;
    size_t _pos = -1;
public:
    CircularBuffer(size_t n)
        : _buffer(n)
    {

    }

    void push(T v)
    {
        if (_buffer.size() == 0)
            throw std::domain_error("buffer is empty");
        if (_pos == _buffer.size() - 1)
            _pos = 0;
        else
            _pos++;
        _buffer[_pos] = v;
    }

    // вставляет на свободное место или использует push
    void insertAtEmpty(T v)
    {
        for (auto &c : _buffer) {
            if (c == T{}) {
                c = v;
                return;
            }
        }
        push(v);
    }

    void remove(T v)
    {
        if (_buffer.size() == 0)
            throw std::domain_error("buffer is empty");
        for (auto &c : _buffer) {
            if (c == v)
                c = T{};
        }
    }

    void print()
    {
        ::printV(_buffer);
    }
};

void test()
{
    CircularBuffer<int> cb(3);
    cb.push(1);
    cb.push(2);
    cb.push(3);
    cb.print();
    cb.push(4);
    cb.push(5);
    cb.print();
    cb.remove(5);
    cb.print();
    cb.insertAtEmpty(6);
    cb.print();
}

#endif // CIRCULARBUFFER_H
