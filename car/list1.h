#ifndef LIST1_H
#define LIST1_H

#include <iostream>

// узел односвязного списка
template<class T>
class Node1
{
public:
    T value {};
    Node1 *next = nullptr;
    Node1(const T &v) { value = v; }
};

// односвязный список
template<class T>
class List1
{
public:
    Node1<T> *head = nullptr;
    Node1<T> *tail = nullptr;
public:
    int count()
    {
        if (!head)
            return 0;
        int i = 0;
        auto p = head;
        while (p) {
            i++;
            p = p->next;
        }
        return i;
    }
    Node1<T> *operator[](int i) const
    {
        if (!head)
            return nullptr;
        auto p = head;
        while (p) {
            if (i == 0)
                return p;
            i--;
            p = p->next;
        }
        return nullptr;
    }
    Node1<T> *add(const T &v)
    {
        auto node = new Node1<T>(v);
        return add(node);
    }

    Node1<T> *add(Node1<T> *node)
    { // чтобы можно было делать пересечения
        if (!head) {
            head = node;
            tail = node;
        } else {
            tail->next = node;
            tail = node;
        }
        return node;
    }

    void detach()
    {
        head = nullptr;
        tail = nullptr;
    }

    void add(const std::initializer_list<T> &list) {
        for (auto &&i : list)
            add(i);
    }

    bool equals(const std::initializer_list<T> &list) {
        if (list.size() != (size_t)count())
            return false;
        auto p = head;
        for (auto &&item : list) {
            if (item != p->value)
                return false;
            p = p->next;
        }
        return true;
    }

    void revert()
    {
        auto p = head;
        if (!p)
            return;
        Node1<T> *newHead = nullptr;
        Node1<T> *newTail = nullptr;
        Node1<T> *prev = nullptr;
        while (p) {
            auto next = p->next;
            if (!newTail)
                newTail = p;
            p->next = prev;
            prev = p;
            p = next; // след. итерация
        }
        newHead = prev;
        head = newHead;
        tail = newTail;
    }

    void remove(Node1<T> *node)
    {
        if (!node)
            return;
        auto p = head;
        Node1<T> *prev = nullptr;
        while (p) {
            if (p == node) {
                if (prev == nullptr) {
                    // это head
                    head = node->next;
                    if (!head)
                        tail = nullptr;
                }
                if (tail == node) {
                    tail = prev;
                }
                if (prev)
                    prev->next = node->next;
                delete node;
                break;
            }
            prev = p;
            p = p->next;
        }
    }

    void clear()
    {
        auto p = head;
        while (p) {
            auto node = p;
            p = p->next;
            delete node;
        }
        head = nullptr;
        tail = nullptr;
    }

    void print()
    {
        if (!head) {
            return;
        }
        auto p = head;
        while (p) {
            std::cout << p->value << std::endl;
            p = p->next;
        }
    }

    void println(std::string sep = "")
    {
        if (!head) {
            return;
        }
        auto p = head;
        while (p) {
            std::cout << p->value << sep;
            p = p->next;
        }
    }

    virtual ~List1()
    {
        clear();
    }
};

void test_list1()
{
    List1<int> list;
    auto n1 = list.add(1);
    auto n2 = list.add(2);
    auto n3 = list.add(3);
    auto n4 = list.add(4);
    auto n5 = list.add(5);
    //list.print();
    list.remove(n1);
    //list.print();
    list.remove(n5);
    //list.print();
    list.remove(n3);
    //list.print();
    list.remove(n2);
    list.remove(n4);
    //list.print();
}

#endif // LIST1_H
