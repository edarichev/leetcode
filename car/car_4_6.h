#ifndef CAR_4_6_H
#define CAR_4_6_H

#include "macro.h"
#include "bnode.h"

using namespace std;

class CAR_4_6
{
public:

    static BNode *getNextNode(BNode *n)
    {
        // если ничего нет
        if (n == nullptr)
            return nullptr;
        // это корень, тоже ничего нет
        auto q = n->parent;
        if (q == nullptr)
            return nullptr;
        if (n == q->left) {
            // это левый узел, попробуем найти правый
            if (q->right)
                return q->right;
        }
        // иначе это правый узел, поднимаемся
        int deep = 1;
        do {
            q = q->parent;
            if (!q)
                return nullptr;
            auto found = getNode(q->right, deep);
            if (found)
                return found;
            deep++;
        } while (true);
        return nullptr;
    }

    static BNode *getNode(BNode *q, int deep) {
        if (deep == 0)
            return q;
        if (!q)
            return nullptr;
        BNode *r = nullptr;
        if (q->left)
            r = getNode(q->left, deep - 1);
        if (r)
            return r;
        if (q->right)
            r = getNode(q->right, deep - 1);
        return r;
    }

    static void test()
    {
        BNode *topValid = new BNode(8);
        auto f4 = topValid->addLeft(4);
        auto f2 = f4->addLeft(2);
        auto f6 = f4->addRight(6);
        auto f10 = topValid->addRight(10);
        auto f11 = f10->addLeft(11);
        auto f20 = f10->addRight(20);

        printBTree(topValid);

        auto n1 = getNextNode(f2);
        ASSERT(n1->value == 6);
        n1 = getNextNode(f6);
        ASSERT(n1->value == 11);
        n1 = getNextNode(f4);
        ASSERT(n1->value == 10);
    }
};


#endif // CAR_4_6_H
