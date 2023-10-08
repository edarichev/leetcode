#ifndef CPPSHKI_H
#define CPPSHKI_H

#include <cstdlib>
#include <memory>
#include <iostream>

// демонстрация реализации операторов new/delete
void testOperatorNewDelete()
{
    class C
    {
    public:
        int x = 13;
        C(){ std::cout << "C::C()\n"; }
        ~C(){ std::cout << "C::~C()\n"; }
    };

    void *p = malloc(sizeof(C));
    C *pc = new (p) C();
    std::cout << pc->x;
    pc->~C();
    free(p);
}

#endif // CPPSHKI_H
