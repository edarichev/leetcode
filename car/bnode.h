#ifndef BNODE_H
#define BNODE_H

#include <iostream>

struct BNode
{
    int value{};
    BNode *left = nullptr;
    BNode *right = nullptr;
    BNode *parent = nullptr;
    BNode(int v) : value(v){};
    ~BNode(){ delete left; delete right; }
    BNode *addLeft(int val)
    {
        if (left)
            delete left;
        left = new BNode(val);
        left->parent = this;
        return left;
    }
    BNode *addRight(int val)
    {
        if (right)
            delete right;
        right = new BNode(val);
        right->parent = this;
        return right;
    }
};

void printBTree(BNode *top, int level = 0)
{
    if (top == nullptr)
        return;
    for (int i = 0; i < level; i++)
        std::cout << " ";
    std::cout << top->value << std::endl;
    printBTree(top->left, level + 1);
    printBTree(top->right, level + 1);
}


#endif // BNODE_H
