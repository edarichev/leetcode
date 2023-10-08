#ifndef P1_3_30_H
#define P1_3_30_H

#include "../helpers.h"

struct Node
{
    int value = 0;
    Node *next = nullptr;
    Node(int v) : value(v) { }
    ~Node()
    {
        if (next)
            delete next;
    }
};

Node *reverse(Node *first)
{
    if (!first)
        return nullptr;
    if (first->next == nullptr)
        return first;
    Node *r = nullptr;
    while (first) {
        auto p = first->next;
        first->next = r;
        r = first;
        first = p;
    }
    return r;
}

void test()
{
    Node *f = new Node(1);
    f->next = new Node(2);
    f->next->next = new Node(3);
    f->next->next->next = new Node(4);

    Node *first = reverse(f);
    Node *p = first;
    while (p) {
        cout << p->value << " ";
        p = p->next;
    }
    delete first;
}

#endif // P1_3_30_H
