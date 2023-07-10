/*
1071. Greatest Common Divisor of Strings
Easy
3.8K
660
Companies
For two strings s and t, we say "t divides s" if and only if s = t + ... + t (i.e., t is concatenated with itself one or more times).

Given two strings str1 and str2, return the largest string x such that x divides both str1 and str2.



Example 1:

Input: str1 = "ABCABC", str2 = "ABC"
Output: "ABC"
Example 2:

Input: str1 = "ABABAB", str2 = "ABAB"
Output: "AB"
Example 3:

Input: str1 = "LEET", str2 = "CODE"
Output: ""


Constraints:

1 <= str1.length, str2.length <= 1000
str1 and str2 consist of English uppercase letters.
 */
#ifndef C1071_H
#define C1071_H

#include "global.h"

class Solution {
public:
    string gcdOfStrings(string str1, string str2) {
        // если каждая подстрока состоит из 1 или более повторяющихся элементов
        // и это одни и те же элементы, то если приклеить одну к другой
        // мы лишь увеличим число повторяющихся частей, притом что слева, что справа
        // - результат должен быть одинаков
        if (str1 + str2 != str2 + str1)
            return "";
        return str1.substr(0, std::gcd(str1.length(), str2.length()));
    }

};

void test()
{
    Solution s;
    string str1 = "ABCABC", str2 = "ABC";
    assert("ABC" == s.gcdOfStrings(str1, str2));
    str1 = "ABABAB", str2 = "ABAB";
    assert("AB" == s.gcdOfStrings(str1, str2));
    str1 = "LEET", str2 = "CODE";
    assert("" == s.gcdOfStrings(str1, str2));
}

#endif // C1071_H
