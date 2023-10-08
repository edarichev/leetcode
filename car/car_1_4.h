#ifndef CAR_1_4_H
#define CAR_1_4_H

#include "macro.h"
#include <string>

/*
Напишите функцию, которая проверяет, является ли заданная строка перестановкой
палиндрома. (Палиндром — слово или фраза, одинаково читающиеся
в прямом и обратном направлении; перестановка — строка, содержащая те
же символы в другом порядке.) Палиндром не ограничивается словами из
словаря.
 */
class CAR_1_4
{
public:
    static bool isPalindrom(const std::string &str)
    {
        size_t n = str.length();
        if (!n)
            return false;
        for (size_t i = 0; i < n / 2; i++) {
            if (str[i] != str[n - i - 1])
                return false;
        }
        return true;
    }

    static bool isPerm(std::string &str, size_t i, const std::string &test)
    {
        if (i == str.length()) {
            return str == test;
        }
        for (size_t j = i; j < str.length(); j++) {
            std::swap(str[i], str[j]);
            if (isPerm(str, i + 1, test))
                return true;
            std::swap(str[i], str[j]);
        }
        return false;
    }

    static void test()
    {
        std::string s1 = "qwerewq";
        std::string s2 = "qwerewq1";
        ASSERT(isPalindrom(s1));
        ASSERT(isPalindrom(s2) == false);
        std::string s1perm = "qweerwq";
        std::string s1permCopy = s1perm;
        ASSERT(isPerm(s1perm, 0, s1));
    }
};

#endif // CAR_1_4_H
