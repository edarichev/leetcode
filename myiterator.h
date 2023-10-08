#ifndef MYITERATOR_H
#define MYITERATOR_H

#include <iterator>

class MyIterator : public std::iterator<std::bidirectional_iterator_tag, int>
{
    int *container = nullptr;
    size_t pos = 0;
public:
    explicit MyIterator(int *ptrContainer) : container(ptrContainer) {}
    MyIterator (const MyIterator &it)
    {
        container = it.container;
        pos = it.pos;
    }
    int& operator *()
    {
        return *(this->container + pos);
    }
    MyIterator &operator++()
    {
        pos++;
        return *this;
    }
    MyIterator &operator--()
    {
        pos++;
        return *this;
    }
    MyIterator &operator=(const MyIterator &it)
    {
        container = it.container;
        pos = it.pos;
        return *this;
    }
    MyIterator operator +(int n)
    {
        MyIterator t(container);
        t.pos = pos + n;
        return t;
    }
    bool operator ==(const MyIterator &it)
    {
        return container == it.container && pos == it.pos;
    }
    bool operator !=(const MyIterator &it)
    {
        return !operator==(it);
    }
};

/*
    int c[] = {1,2,3,4,5};
    MyIterator it(c);
    MyIterator itBegin = it;
    *itBegin = 56;
    MyIterator itEnd = it + 5;
    for (; it != itEnd; ++it)
    {
        cout << *it << " ";
    }

 */
#endif // MYITERATOR_H
