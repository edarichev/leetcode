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
        if (n == nullptr)
            return nullptr;
        if (n->right != nullptr) {
            return leftMostChild(n->right);
        } else {
            BNode *q = n;
            BNode *x = q->parent;
            while (x != nullptr && x->left != q) {
                q = x;
                x = x->parent;
            }
            return x;
        }
    }

    static BNode *leftMostChild(BNode *n)
    {
        if (n == nullptr)
            return nullptr;
        while (n->left != nullptr) {
            n = n->left;
        }
        return n;
    }

    static void printResult(BNode *n1)
    {
        if (n1 == nullptr)
            cout << "null" << endl;
        else
            cout << n1->value << endl;
    }

    static void test()
    {
        BNode *topValid = new BNode(20);
        topValid->addLeft(10);
        auto f5 = topValid->left->addLeft(5);
        auto f3 = topValid->left->left->addLeft(3);
        auto f7 = topValid->left->left->addRight(7);
        auto f15 = topValid->left->addRight(15);
        auto f17 = topValid->left->right->addRight(17);

        //printBTree(topValid);

        auto n1 = getNextNode(f5);
        ASSERT(n1->value == 15);
        n1 = getNextNode(f3);
        ASSERT(n1->value == 7);
        n1 = getNextNode(f7);
        ASSERT(n1->value == 17);
    }
};


#endif // CAR_4_6_H
