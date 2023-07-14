/*
12. Integer to Roman
Medium
5.9K
5.2K
Companies
Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

Symbol       Value
I             1
V             5
X             10
L             50
C             100
D             500
M             1000
For example, 2 is written as II in Roman numeral, just two one's added together. 12 is written as XII, which is simply X + II. The number 27 is written as XXVII, which is XX + V + II.

Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

I can be placed before V (5) and X (10) to make 4 and 9.
X can be placed before L (50) and C (100) to make 40 and 90.
C can be placed before D (500) and M (1000) to make 400 and 900.
Given an integer, convert it to a roman numeral.



Example 1:

Input: num = 3
Output: "III"
Explanation: 3 is represented as 3 ones.
Example 2:

Input: num = 58
Output: "LVIII"
Explanation: L = 50, V = 5, III = 3.
Example 3:

Input: num = 1994
Output: "MCMXCIV"
Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.

Constraints:

1 <= num <= 3999

 */
#ifndef C0012_H
#define C0012_H

#include "global.h"

static int _=[](){ios_base::sync_with_stdio(false);return 0;}();

class Solution {
public:

    string intToRoman(int num) {
        string se, sd, sh, st;
        int e = num % 10;
        switch (e) {
        case 1: se.append(1, 'I'); break;
        case 2: se.append(2, 'I'); break;
        case 3: se.append(3, 'I'); break;
        case 4: se.append("IV"); break;
        case 5: se.append(1, 'V'); break;
        case 6: se.append("VI"); break;
        case 7: se.append("VII"); break;
        case 8: se.append("VIII"); break;
        case 9: se.append("IX"); break;
        }
        num /= 10;
        if (!num)
            return se;
        int d = num % 10;
        switch (d) {
        case 1: sd.append(1, 'X'); break;
        case 2: sd.append(2, 'X'); break;
        case 3: sd.append(3, 'X'); break;
        case 4: sd.append("XL"); break;
        case 5: sd.append(1, 'L'); break;
        case 6: sd.append("LX"); break;
        case 7: sd.append("LXX"); break;
        case 8: sd.append("LXXX"); break;
        case 9: sd.append("XC"); break;
        }
        num /= 10;
        if (!num)
            return sd + se;
        int h = num % 10;
        switch (h) {
        case 1: sh.append(1, 'C'); break;
        case 2: sh.append(2, 'C'); break;
        case 3: sh.append(3, 'C'); break;
        case 4: sh.append("CD"); break;
        case 5: sh.append(1, 'D'); break;
        case 6: sh.append("DC"); break;
        case 7: sh.append("DCC"); break;
        case 8: sh.append("DCCC"); break;
        case 9: sh.append("CM"); break;
        }
        num /= 10;
        if (!num)
            return sh + sd + se;
        int t = num;
        switch (t) {
        case 1: st.append(1, 'M'); break;
        case 2: st.append(2, 'M'); break;
        case 3: st.append(3, 'M'); break;
        }
        return st + sh + sd + se;
    }
};

void test()
{
    Solution s;
    int num = 3;
    assert("III" == s.intToRoman(num));
    num = 58;
    assert("LVIII" == s.intToRoman(num));
    num = 1994;
    assert("MCMXCIV" == s.intToRoman(num));
}

#endif // C0012_H
