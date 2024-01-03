#ifndef P1_3_29_H
#define P1_3_29_H

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

class CircularQueue
{
    Node *last = nullptr;
public:
    ~CircularQueue()
    {
        if (!last)
            return;
        Node *p = last->next;
        if (last == p) {
            p->next = nullptr;
            delete p;
            return;
        }
        // цепочка теперь от p
        last->next = nullptr; // разорвать
        delete p;
    }

    Node *push(int v)
    {
        Node *n = new Node(v);
        if (last == nullptr) {
            last = n;
            last->next = last;
        } else {
            // разорвать цепочку
            Node *p = last->next;
            // вставить n
            last->next = n;
            // соединить кольцо
            n->next = p;
        }
        return n;
    }

    int pop()
    {
        Node *p = last;
        if (!p)
            return INT32_MIN;
        if (last == last->next) {
            int v = last->value;
            last->next = nullptr;
            delete last;
            last = nullptr;
            return v;
        }
        Node *n = p->next;
        // ищем предыдущий
        while (n->next != last) {
            n = n->next;
        }
        n->next = last->next;
        last->next = nullptr;
        int v = last->value;
        delete last;
        last = n;
        return v;
    }
};

void test()
{
    CircularQueue q;
    q.push(1);
    q.push(2);
    q.push(3);
    cout << q.pop() << " " << q.pop() << " " << q.pop() << " ";
}

#endif // P1_3_29_H
