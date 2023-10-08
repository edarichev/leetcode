#ifndef CAR_4_2_H
#define CAR_4_2_H

#include "macro.h"
#include <vector>
#include <algorithm>

class CAR_4_2
{
public:

    struct BNode
    {
        int value {0};
        BNode *left = nullptr;
        BNode *right = nullptr;

        BNode(int v) : value(v) {}

        ~BNode()
        {
            delete left;
            delete right;
        }
    };

    static BNode *createMinimalBST(const std::vector<int> &arr, int start, int end)
    {
        if (end < start)
            return nullptr;
        int mid = (start + end) / 2;
        BNode *n = new BNode(arr[mid]);
        n->left = createMinimalBST(arr, start, mid - 1);
        n->right = createMinimalBST(arr, mid + 1, end);
        return n;
    }

    static BNode *createTree(const std::vector<int> &arr)
    {
        return createMinimalBST(arr, 0, arr.size() - 1);
    }

    static void test()
    {
        std::vector<int> v {1,2,3,4,5,6,7,8,9,10};
        std::sort(v.begin(), v.end());
        BNode *top = createTree(v);
        std::cout << top->value;
        delete top;
    }
};

#endif // CAR_4_2_H
