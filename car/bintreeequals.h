#ifndef BINTREEEQUALS_H
#define BINTREEEQUALS_H

#include "macro.h"

class BinTreeEq
{
public:
    struct TreeNode
    {
        int val;
        TreeNode *left = nullptr;
        TreeNode *right = nullptr;

        TreeNode(int v, TreeNode *l = nullptr, TreeNode *r = nullptr) : val(v), left(l), right(r) {}

        virtual ~TreeNode()
        {
            delete left;
            delete right;
        }
    };

    bool isTreeEquals(TreeNode *t1, TreeNode *t2)
    {
        if (t1 == t2 && t1 == nullptr)
            return true;
        if (t1 == nullptr && t2 != nullptr)
            return false;
        if (t2 == nullptr && t1 != nullptr)
            return false;
        if (t1->val != t2->val)
            return false;
        return isTreeEquals(t1->left, t2->left) && isTreeEquals(t1->right, t2->right);
    }

    void test()
    {
        TreeNode *t1 = new TreeNode(0);
        t1->left = new TreeNode(1);
        t1->right = new TreeNode(2);
        t1->left->left = new TreeNode(3);

        TreeNode *t2 = new TreeNode(0);
        t2->left = new TreeNode(1);
        t2->right = new TreeNode(2);
        t2->left->left = new TreeNode(3);

        ASSERT(isTreeEquals(t1, t2));
        delete t1;
        delete t2;
    }
};

#endif // BINTREEEQUALS_H
