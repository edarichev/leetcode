#ifndef CAR_4_5_H
#define CAR_4_5_H

#include "macro.h"
#include "bnode.h"

using namespace std;

class CAR_4_5
{
public:

    static bool isBSTRange(BNode *n, int *lo, int *hi)
    {
        if (n == nullptr) {
            return true;
        }
        if ((lo && n->value <= *lo) || (hi && n->value > *hi))
            return false;
        if (!isBSTRange(n->left, lo, &n->value))
            return false;
        if (!isBSTRange(n->right, &n->value, hi))
            return false;
        return true;
    }

    static bool isBST(BNode *n)
    {
        if (n == nullptr)
            return true;
        return isBSTRange(n, nullptr, nullptr);
    }

    static void test()
    {
        BNode *topValid = new BNode(20);
        topValid->addLeft(10);
        topValid->left->addLeft(5);
        topValid->left->left->addLeft(3);
        topValid->left->left->addRight(7);
        topValid->left->addRight(15);
        topValid->left->right->addRight(17);
        topValid->addRight(30);
        //printBTree(topValid);
        ASSERT(isBST(topValid));

        BNode *nonValid = new BNode(20);
        nonValid->left = new BNode(10);
        nonValid->left->right = new BNode(25);
        nonValid->right = new BNode(30);
        ASSERT(!isBST(nonValid));

        delete topValid;
        delete nonValid;
    }
};

#endif // CAR_4_5_H
