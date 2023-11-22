/*
Given the root of a binary tree, return the inorder traversal of its nodes' values.



Example 1:


Input: root = [1,null,2,3]
Output: [1,3,2]
Example 2:

Input: root = []
Output: []
Example 3:

Input: root = [1]
Output: [1]


Constraints:

The number of nodes in the tree is in the range [0, 100].
-100 <= Node.val <= 100


Follow up: Recursive solution is trivial, could you do it iteratively?
 */
#ifndef C0094_BINARY_TREE_INORDER_TRAVERSAL_H
#define C0094_BINARY_TREE_INORDER_TRAVERSAL_H

#include "helpers.h"

// Definition for a binary tree node.
struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

static int _ = [](){ios_base::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr);return 0;}();

class Solution {
public:
    void trav(TreeNode *n, vector<int> &v)
    {
        if (!n)
            return;
        trav(n->left, v);
        v.push_back(n->val);
        trav(n->right, v);
    }
    vector<int> inorderTraversal(TreeNode* root) {
        vector<int> v;
        if (!root)
            return v;
        trav(root, v);
        return v;
    }
};

void test()
{
    TreeNode r1(1);
    TreeNode r2(2);
    TreeNode r3(3);
    r1.right = &r2;
    r2.left = &r3;

    vector<int> result1 {1, 3, 2};
    assert(result1 == Solution().inorderTraversal(&r1));
}

#endif // C0094_BINARY_TREE_INORDER_TRAVERSAL_H
