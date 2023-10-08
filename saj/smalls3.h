#ifndef SMALLS3_H
#define SMALLS3_H

struct Node
{
    int value;
    Node *next = nullptr;
    Node(int v) : value(v){}
    ~Node()
    {
        Node *n = next;
        if (n)
            delete n;
    }
};

void prints(Node *n)
{
    while (n) {
        cout << n->value << " ";
        n = n->next;
    }
    cout << endl;
}

void removeAt(Node *top, int k)
{
    auto n = top;
    Node *prev = nullptr;
    while (n) {
        if (!k) {
            if (prev) {
                prev->next = n->next;
            }
            n->next = nullptr;
            delete n;
            return;
        }
        k--;
        prev = n;
        n = n->next;
    }
}

bool find(Node *top, int v)
{
    auto n = top;
    while (n) {
        if (n->value == v)
            return true;
        n = n->next;
    }
    return false;
}

void remove(Node *first, Node *r)
{
    auto n = first;
    while (n) {
        if (n == r) {
            auto next = n->next;
            if (!next)
                return;
            n->next = next->next;
            next->next = nullptr;
            delete next;
            return;
        }
        n = n->next;
    }
}

void insertAfter(Node *after, Node *n)
{
    if (!after || !n)
        return;
    auto next = after->next;
    after->next = n;
    n->next = next;
}

void remove(Node *&first, int key)
{
    auto n = first;
    Node *prev = nullptr;
    while (n) {
        if (n->value == key) {
            if (n == first) {
                first = n->next;
            }
            if (prev)
                prev->next = n->next;
            auto p = n->next;
            n->next = nullptr;
            delete n;
            n = p;
            continue;
        }
        prev = n;
        n = n->next;
    }
}

int maxx(Node *first)
{
    if (!first)
        return 0;
    int m = INT32_MIN;
    auto n = first;
    while (n) {
        if (n->value > m)
            m = n->value;
        n = n->next;
    }
    return m;
}

int maxx(Node *first, int m)
{
    if (!first)
        return m;
    if (first->value > m)
        m = first->value;
    return maxx(first->next, m);
}
/*
    Node *first = new Node(1);
    first->next = new Node(2);
    first->next->next = new Node(3);
    first->next->next->next = new Node(2);

    prints(first);
    cout << maxx(first, INT32_MIN);
    delete first;

 */

#endif // SMALLS3_H
