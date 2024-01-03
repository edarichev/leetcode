/**
 * Этот файл - часть библиотеки STK
 * @file revertlist.h
 * @author Даричев Е.А.
 * @date 17.06.2023
 * @brief Развернуть односвязный список
 */
#ifndef REVERTLIST_H
#define REVERTLIST_H

#include <iostream>

using namespace std;

struct ListNode
{
    int val;
    ListNode *next;
    ListNode(): val(0), next(nullptr){}
    ListNode(int x): val(x), next(nullptr){}
    ListNode(int x, ListNode *m): val(x), next(m){}
};

ListNode *revert(ListNode *head)
{
    if (!head || !head->next)
        return head;
    ListNode *prev = nullptr;
    auto p = head;
    while (p) {
        head = p;
        p = p->next;
        head->next = prev;
        prev = head;
    }
    return head;
}

void print_ListNodes(ListNode *head)
{
    ListNode *p = head;
    while (p) {
        cout << p->val << " ";
        p = p->next;
    }
    cout << endl;
}

void test_reverseList()
{
    ListNode n1(1);
    ListNode n2(2);
    ListNode n3(3);
    ListNode n4(4);

    ListNode *head = &n1;
    n1.next = &n2;
    n2.next = &n3;
    n3.next = &n4;
    print_ListNodes(head);
    head = revert(head);
    print_ListNodes(head);

}

#endif // REVERTLIST_H
