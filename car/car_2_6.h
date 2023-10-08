#ifndef CAR_2_6_H
#define CAR_2_6_H

#include "macro.h"
#include "list1.h"
#include <stack>

class CAR_2_6
{
public:

    template<class T>
    static bool isPalindrom(const List1<T> &a)
    {
        std::stack<T> st;
        auto p = a.head;
        if (!p)
            return true;//пусть так
        int n = 0;
        while (p) {
            st.push(p->value);
            p = p->next;
            n++;
        }
        p = a.head;
        int i = 0;
        while (p && i < n / 2) {
            if (p->value != st.top())
                return false;
            i++;
            st.pop();
            p = p->next;
        }
        return true;
    }

    // Функция для определения, является ли данный связанный список палиндромом
    template<class T>
    static bool isPalindrome(Node1<T>* curr, Node1<T>* &headRef)
    {
        // базовый случай: достигнут конец списка
        if (curr == nullptr) {
            return true;
        }

        // продвигаемся до конца списка и
        // возвращаем false в случае конфликта
        if (!isPalindrome(curr->next, headRef)) {
            return false;
        }

        // проверка против "зеркала" при "возвращении" из рекурсии
        if (curr->value != headRef->value) {
            return false;
        }

        // продвигаем "зеркало" на один шаг за каждый шаг, "возвращенный назад" в рекурсии
        headRef = headRef->next;
        return true;
    }

    // Определить, является ли данный связанный список палиндромом или нет.
    // Функция принимает указатель на головной узел списка.
    template<class T>
    static bool isPalindrome(Node1<T>* head) {
        return isPalindrome(head, head);
    }

    static void test()
    {
        List1<int> list1;
        list1.add({1,2,3,2,1});
        ASSERT(isPalindrom(list1));
        List1<int> list2;
        list2.add({1,2,2,1});
        ASSERT(isPalindrom(list2));
        List1<int> list3;
        list3.add({1,2,2,1,4});
        ASSERT(isPalindrom(list3) == false);
        ASSERT(isPalindrome(list3.head) == false);
    }
};

#endif // CAR_2_6_H
