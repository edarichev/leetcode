/*
You are given the heads of two sorted linked lists list1 and list2.

Merge the two lists into one sorted list. The list should be made by splicing together the nodes of the first two lists.

Return the head of the merged linked list.



Example 1:


Input: list1 = [1,2,4], list2 = [1,3,4]
Output: [1,1,2,3,4,4]
Example 2:

Input: list1 = [], list2 = []
Output: []
Example 3:

Input: list1 = [], list2 = [0]
Output: [0]


Constraints:

The number of nodes in both lists is in the range [0, 50].
-100 <= Node.val <= 100
Both list1 and list2 are sorted in non-decreasing order.
 */
#ifndef C0021_MERGE_TWO_SORTED_LISTS_H
#define C0021_MERGE_TWO_SORTED_LISTS_H

#include "global.h"

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
    ListNode* mergeTwoListsWithMemoryAlloc(ListNode* list1, ListNode* list2) {
        ListNode *list = nullptr;
        ListNode *p = nullptr;
        ListNode *current = nullptr;
        while (true) {
            if (!list1) {
                // делаем копию второго списка
                while (list2) {
                    p = new ListNode(list2->val);
                    if (!list) {
                        list = p;
                        current = p;
                    } else {
                        current->next = p;
                        current = p;
                    }
                    list2 = list2->next;
                }
                break;
            }
            if (!list2) {
                // делаем копию первого списка
                while (list1) {
                    p = new ListNode(list1->val);
                    if (!list) {
                        list = p;
                        current = p;
                    } else {
                        current->next = p;
                        current = p;
                    }
                    list1 = list1->next;
                }
                break;
            }
            // общий случай
            if (list1->val < list2->val) {
                p = new ListNode(list1->val);
                list1 = list1->next;
            } else {
                p = new ListNode(list2->val);
                list2 = list2->next;
            }
            if (!list) {
                list = p;
                current = p;
            } else {
                current->next = p;
                current = p;
            }
        }
        return list;
    }

    ListNode* mergeTwoLists(ListNode* list1, ListNode* list2) {
        // реорганизация двух списков в один без создания нового списка
        ListNode *list = nullptr;
        ListNode *p = nullptr;
        while (list1 && list2) {
            // только если оба списка непусты
            if (list1->val < list2->val) {
                if (!list) {
                    list = list1;
                } else {
                    p->next = list1;
                }
                p = list1;
                list1 = list1->next;
            } else {
                if (!list) {
                    list = list2;
                } else {
                    p->next = list2;
                }
                p = list2;
                list2 = list2->next;
            }
        }
        if (list1) {
            if (list)
                p->next = list1;
            else
                list = list1;
        } else if (list2) {
            if (list)
                p->next = list2;
            else
                list = list2;
        }
        return list;
    }
};

void test()
{
    ListNode a1(1);
    ListNode a2(2);
    ListNode a3(4);
    a1.next = &a2;
    a2.next = &a3;

    ListNode b1(1);
    ListNode b2(3);
    ListNode b3(4);
    b1.next = &b2;
    b2.next = &b3;

    ListNode c1(1);
    ListNode c2(1);
    ListNode c3(2);
    ListNode c4(3);
    ListNode c5(4);
    ListNode c6(4);

    c1.next = &c2;
    c2.next = &c3;
    c3.next = &c4;
    c4.next = &c5;
    c5.next = &c6;

    ListNode *newList = Solution().mergeTwoLists(&a1, &b1);
    ListNode *p1 = &c1;
    ListNode *p2 = newList;
    while (p1) {
        assert(p2 != nullptr);
        assert(p1->val == p2->val);
        p1 = p1->next;
        p2 = p2->next;
    }
    //delete newList; // с версией созздания копии
}

#endif // C0021_MERGE_TWO_SORTED_LISTS_H
