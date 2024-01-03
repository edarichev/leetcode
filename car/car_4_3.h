#ifndef CAR_4_3_H
#define CAR_4_3_H

#include "macro.h"
#include <algorithm>

class CAR_4_3
{
public:

    struct BNode
    {
        int value{};
        BNode *left = nullptr;
        BNode *right = nullptr;
        BNode(int v) : value(v){};
        ~BNode(){ delete left; delete right; }
    };

    static void makeLists(BNode *node, size_t level, std::vector<std::vector<int>> &lst)
    {
        if (node == nullptr)
            return;
        //if (std::find(visited.begin(), visited.end(), node) != visited.end())
        //    return;
        //visited.push_back(node);
        // можно и хэш-таблицу, где ключ==индекс
        while (lst.size() < level + 1) // добавить пустой массив на этот индекс, если нет
            lst.push_back(std::vector<int>());
        lst[level].push_back(node->value);
        makeLists(node->left, level+1, lst);
        makeLists(node->right, level+1, lst);
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
        // 0
        // 1 2
        // 3 4 5 6
        // 8

        // индекс == номер уровня дерева
        std::vector<std::vector<int>> result;
        makeLists(top, 0, result);
        for (auto &&lst : result) {
            print(lst);
        }
        delete top;
    }
};

#endif // CAR_4_3_H
