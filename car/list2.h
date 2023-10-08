/**
 * @file testlist.h
 * @author Даричев Е.А.
 * @date 15.06.2023
 * @brief Список
 */
#ifndef LIST2_H
#define LIST2_H

#include <iostream>

using namespace std;

// узел двусвязного списка
template<class T>
class Node2
{
public:
    Node2 *prev = nullptr;
    Node2 *next = nullptr;
    T value;
};

// двусвязный список
template<class T>
class List2 {
    Node2<T> *current = nullptr;
public:
    Node2<T> *root = nullptr;

    Node2<T> *last()
    {
        auto p = root;
        while (p) {
            if (p->next == nullptr)
                return p;
            p = p->next;
        }
        return nullptr;
    }

    void add(T value)
    {
        auto lastNode2 = last();
        auto newNode2 = new Node2<T>{lastNode2, nullptr, value};
        if (root == nullptr) {
            root = newNode2;
        } else {
            lastNode2->next = newNode2;
        }
    }

    void remove(Node2<T> *Node2)
    {
        if (Node2 == root) {
            root = root->next;
            delete Node2;
            return;
        }
        auto p = root->next;
        while (p) {
            if (p == Node2) {
                Node2->prev->next = Node2->next;
                if (Node2->next != nullptr)
                    Node2->next->prev = Node2->prev;
                delete Node2;
                return;
            }
            p = p->next;
        }
    }

    Node2<T> *at(int pos)
    {
        int i = 0;
        auto p = root;
        while (p) {
            if (i == pos)
                return p;
            p = p->next;
            i++;
        }
        return nullptr;
    }

    virtual ~List2()
    {
        auto p = root;
        while (p) {
            auto Node2 = p;
            p = p->next;
            delete Node2;
        }
    }

    void print()
    {
        auto p = root;
        if (!p)
            return;
        while (p) {
            cout << p->value << endl;
            p = p->next;
        }
    }
};

void test_list()
{
    List2<int> list;
    list.add(5);
    list.add(6);
    list.add(7);
    list.print();
    auto n = list.at(2);
    cout << n->value << endl;
    list.remove(n);
    list.add(5);
    list.add(6);
    list.add(7);
    list.print();
}

#endif // LIST2_H
