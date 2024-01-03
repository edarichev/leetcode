/*
2. Add Two Numbers
Medium
Topics
Companies
You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.



Example 1:


Input: l1 = [2,4,3], l2 = [5,6,4]
Output: [7,0,8]
Explanation: 342 + 465 = 807.
Example 2:

Input: l1 = [0], l2 = [0]
Output: [0]
Example 3:

Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
Output: [8,9,9,9,0,0,0,1]


Constraints:

The number of nodes in each linked list is in the range [1, 100].
0 <= Node.val <= 9
It is guaranteed that the list represents a number that does not have leading zeros.
 */
#ifndef C0002_ADD_TWO_NUMBERS_H
#define C0002_ADD_TWO_NUMBERS_H

#include "helpers.h"

static const int _=[]{ios::sync_with_stdio(false);cin.tie(nullptr);cout.tie(nullptr);return 0;}();

// Definition for singly-linked list.
struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

class Solution {

public:
    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
        // нужно создавать новый, в этой задаче делается освобождение памяти на leetcode
        ListNode* list = nullptr, *current = nullptr;
        int carry = 0;
        while (l1 || l2) {
            int c = (l1 ? l1->val : 0) +
                    (l2 ? l2->val : 0) + carry;
            if (c > 9) {
                c -= 10;
                carry = 1;
            } else {
                carry = 0;
            }
            ListNode *p = new ListNode(c);
            if (!list) {
                list = p;
            }
            else {
                current->next = p;
            }
            current = p;
            if (l1)
                l1 = l1->next;
            if (l2)
                l2 = l2->next;
        }
        if (carry) {
            ListNode *p = new ListNode(1);
            if (!list) {
                list = p;
            }
            else {
                current->next = p;
            }
        }
        return list;
    }
};

void test()
{
    ListNode a1(9);
    ListNode a2(9);
    ListNode a3(9);
    a1.next = &a2;
    a2.next = &a3;

    ListNode b1(9);
    ListNode b2(9);
    ListNode b3(9);
    b1.next = &b2;
    b2.next = &b3;

    ListNode c1(8);
    ListNode c2(9);
    ListNode c3(9);
    ListNode c4(1);

    c1.next = &c2;
    c2.next = &c3;
    c3.next = &c4;

    ListNode *newList = Solution().addTwoNumbers(&a1, &b1);
    ListNode *p1 = &c1;
    ListNode *p2 = newList;
    while (p1) {
        assert(p2 != nullptr);
        assert(p1->val == p2->val);
        p1 = p1->next;
        p2 = p2->next;
    }
}

#endif // C0002_ADD_TWO_NUMBERS_H
