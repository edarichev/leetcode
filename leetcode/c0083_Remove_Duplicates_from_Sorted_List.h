/*
83. Remove Duplicates from Sorted List
Easy
Topics
Companies
Given the head of a sorted linked list, delete all duplicates such that each element appears only once. Return the linked list sorted as well.



Example 1:
img: list1.jpg

Input: head = [1,1,2]
Output: [1,2]
Example 2:
img: list2.jpg

Input: head = [1,1,2,3,3]
Output: [1,2,3]


Constraints:

The number of nodes in the list is in the range [0, 300].
-100 <= Node.val <= 100
The list is guaranteed to be sorted in ascending order.
 */
#ifndef C0083_REMOVE_DUPLICATES_FROM_SORTED_LIST_H
#define C0083_REMOVE_DUPLICATES_FROM_SORTED_LIST_H

#include "helpers.h"

// Definition for singly-linked list.
struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};


static int _ = [](){ios_base::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr);return 0;}();

class Solution {
public:
    ListNode* deleteDuplicates(ListNode* head) {
        ListNode *list = nullptr;
        if (!head)
            return nullptr;
        list = new ListNode(head->val);
        ListNode *t = list;
        ListNode *p = head->next;
        while (p) {
            while (p && p->val == t->val) {
                p = p->next;
                if (!p)
                    return list;
            }
            t->next = new ListNode(p->val);
            t = t->next;
            p = p->next;
        }
        return list;
    }
};

void test()
{
    ListNode a1(1);
    ListNode a2(1);
    ListNode a3(2);
    ListNode a4(3);
    ListNode a5(3);
    a1.next = &a2;
    a2.next = &a3;
    a3.next = &a4;
    a4.next = &a5;

    ListNode *r = Solution().deleteDuplicates(&a1);
    assert(r->val == 1);
    assert(r->next->val == 2);
    assert(r->next->next->val == 3);
    while (r){
        auto *p = r->next;
        delete r;
        r = p;
    }
}

#endif // C0083_REMOVE_DUPLICATES_FROM_SORTED_LIST_H
