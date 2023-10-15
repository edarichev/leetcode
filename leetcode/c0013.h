/*
13. Roman to Integer
Easy
11.2K
642
Companies
Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

Symbol       Value
I             1+
V             5+
X             10+
L             50
C             100+
D             500+
M             1000+
For example, 2 is written as II in Roman numeral, just two ones added together. 12 is written as XII, which is simply X + II. The number 27 is written as XXVII, which is XX + V + II.

Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

I can be placed before V (5) and X (10) to make 4 and 9.
X can be placed before L (50) and C (100) to make 40 and 90.
C can be placed before D (500) and M (1000) to make 400 and 900.
Given a roman numeral, convert it to an integer.



Example 1:

Input: s = "III"
Output: 3
Explanation: III = 3.
Example 2:

Input: s = "LVIII"
Output: 58
Explanation: L = 50, V= 5, III = 3.
Example 3:

Input: s = "MCMXCIV"
Output: 1994
Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.


Constraints:

1 <= s.length <= 15
s contains only the characters ('I', 'V', 'X', 'L', 'C', 'D', 'M').
It is guaranteed that s is a valid roman numeral in the range [1, 3999].
 */
#ifndef C0013_H
#define C0013_H

#include "global.h"


class Solution {
public:
    int romanToInt1(string s) noexcept {
        // храним слагаемые (для наглядности)
        ios_base::sync_with_stdio(false);
        if (!s.length())
            return 0;

        int x = 0;
        int prev = 0;
        vector<int> adds(s.length()); // слагаемые
        // MCMXCIV = 1000 - 100 + 1000 - 10 + 100 - 1 + 5;
        for (size_t i = 0; i < s.length(); i++) {
            int number = 0;
            switch (s[i]) {
            case 'M':
                number = 1000;
                if (prev == 100)
                    adds.back() = -adds.back();
                break;
            case 'D':
                number = 500;
                if (prev == 100)
                    adds.back() = -adds.back();
                break;
            case 'C':
                number = 100;
                if (prev == 10)
                    adds.back() = -adds.back();
                break;
            case 'L':
                number = 50;
                if (prev == 10)
                    adds.back() = -adds.back();
                break;
            case 'X':
                number = 10;
                if (prev == 1)
                    adds.back() = -adds.back();
                break;
            case 'V':
                number = 5;
                if (prev == 1)
                    adds.back() = -adds.back();
                break;
            case 'I': number = 1; break;
            default:
                return 0;
            }
            adds.push_back(number);
            prev = number;
        }
        x = accumulate(adds.begin(), adds.end(), decltype (adds)::value_type(0));
        return x;
    }

    int romanToInt2(string s) noexcept {
        // вычисляем сразу, если встретилось вычитаемое, вычтем удвоенное
        // это побыстрее и памяти поменьше
        ios_base::sync_with_stdio(false);
        if (!s.length())
            return 0;

        int x = 0;
        int prev = 0;
        // MCMXCIV = 1000 - 100 + 1000 - 10 + 100 - 1 + 5;
        for (size_t i = 0; i < s.length(); i++) {
            int number = 0;
            switch (s[i]) {
            case 'M':
                number = 1000;
                if (prev == 100)
                    x -= 2*prev;
                break;
            case 'D':
                number = 500;
                if (prev == 100)
                    x -= 2*prev;
                break;
            case 'C':
                number = 100;
                if (prev == 10)
                    x -= 2*prev;
                break;
            case 'L':
                number = 50;
                if (prev == 10)
                    x -= 2*prev;
                break;
            case 'X':
                number = 10;
                if (prev == 1)
                    x -= 2*prev;
                break;
            case 'V':
                number = 5;
                if (prev == 1)
                    x -= 2*prev;
                break;
            case 'I': number = 1; break;
            default:
                return 0;
            }
            x += number;
            prev = number;
        }
        return x;
    }

    int romanToInt(string s) noexcept {
        // ещё быстрее 0ms
        ios_base::sync_with_stdio(false);
        if (!s.length())
            return 0;

        int x = 0;
        // MCMXCIV = 1000 - 100 + 1000 - 10 + 100 - 1 + 5;
        for (size_t i = 0; i < s.length(); i++) {
            char s0 = s[i];
            char s1 = s[i+1];
            if (s0 == 'C') {
                if (s1 == 'M') {
                    x += 900;
                    i++;
                } else if (s1 == 'D') {
                    x += 400;
                    i++;
                } else
                    x += 100;
                continue;
            } else if (s0 == 'X') {
                if (s1 == 'L') {
                    x += 40;
                    i++;
                } else if (s1 == 'C') {
                    x += 90;
                    i++;
                } else
                    x += 10;
                continue;
            } else if (s0 == 'I') {
                if (s1 == 'X') {
                    x += 9;
                    i++;
                } else if (s1 == 'V') {
                    x += 4;
                    i++;
                } else
                    x += 1;
                continue;
            } else if (s0 == 'M') {
                x += 1000;
            } else if (s0 == 'V') {
                x += 5;
            } else if (s0 == 'D') {
                x += 500;
            } else if (s0 == 'L') {
                x += 50;
            }

        }
        return x;
    }
};


void test()
{
    string s = "LVIII";
    Solution sl;
    cout << sl.romanToInt(s) << endl;

    s = "III";
    cout << sl.romanToInt(s) << endl;

    s = "MCMXCIV";
    cout << sl.romanToInt(s) << endl;
}

#endif // C0013_H
