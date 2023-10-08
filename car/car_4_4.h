#ifndef CAR_4_4_H
#define CAR_4_4_H

#include "macro.h"
#include <algorithm>
#include "bnode.h"

class CAR_4_4
{
public:

    static int checkHeight(BNode *n)
    {
        if (!n)
            return -1; // высота пустого ==-1
        int leftHeight = checkHeight(n->left);
        if (leftHeight == INT32_MIN)
            return INT32_MIN;
        int rightHeight = checkHeight(n->right);
        if (rightHeight == INT32_MIN)
            return INT32_MIN;
        if (abs(leftHeight - rightHeight) > 1)
            return INT32_MIN;
        // +1, т.к. если дерево пусто, его уровень == -1
        // а при n!=null и left|right==null высота == 0, а рекурсия вернёт -1
        // для пустых дочерних деревьев
        // 0 - номер уровня верхнего непустого узла
        return std::max(leftHeight, rightHeight) + 1;
    }

    static bool balanced(BNode *n)
    {
        return checkHeight(n) != INT32_MIN;
    }

    static void test()
    {
        BNode *top = new BNode(0);
        top->left = new BNode(1);
        top->right = new BNode(2);
        top->left->left = new BNode(3);
        top->left->right = new BNode(4);
        top->right->left = new BNode(5);
        top->right->right = new BNode(6);
        top->right->right->right = new BNode(8);
        ASSERT(balanced(top));
        top->right->right->right->right = new BNode(80);
        top->right->right->right->right->right = new BNode(90);
        // 0
        // 1 2
        // 3 4 5 6
        // 8
        // true
        ASSERT(balanced(top) == false);
        delete top;
    }
};

#endif // CAR_4_4_H
