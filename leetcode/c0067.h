/*
67. Add Binary
Easy
8.3K
825
Companies
Given two binary strings a and b, return their sum as a binary string.



Example 1:

Input: a = "11", b = "1"
Output: "100"
Example 2:

Input: a = "1010", b = "1011"
Output: "10101"


Constraints:

1 <= a.length, b.length <= 104
a and b consist only of '0' or '1' characters.
Each string does not contain leading zeros except for the zero itself.
 */
#ifndef C0067_H
#define C0067_H

#include "global.h"

static int _=[](){ios_base::sync_with_stdio(false);return 0;}();

class Solution {
public:
    string addBinary(const string &a, const string &b) {
        int len1 = a.length(), len2 = b.length();
        int n = min(len1, len2);
        if (n == 0)
            return "";
        string r;
        r.reserve(max(len1, len2) + 2);
        const string &s1 = a.length() > b.length() ? a : b;
        const string &s2 = a.length() <= b.length() ? a : b;
        int j = s1.length() - 1; // длинная
        int cf = 0;
        int k = 0;
        for (int i = s2.length() - 1; i >= 0; i--, j--, k++) { // по короткой
            int a = s1[j] - '0';
            int b = s2[i] - '0';
            int sum = a + b + cf;
            cf = sum > 1;
            r.push_back((sum == 1 || sum == 3) ? '1' : '0');
        }
        if (j >= 0) {
            // остаток длинной строки
            for (; j >= 0; j--, k++) {
                int a = s1[j] - '0';
                int sum = a + cf;
                cf = sum > 1;
                r.push_back((sum == 1 || sum == 3) ? '1' : '0');
            }
        }
        if (cf)
            r.push_back('1');
        std::reverse(r.begin(), r.end());
        return r;
    }
};

void test()
{
    string a = "1111", b = "1111";
    Solution s;
    assert("11110" == s.addBinary(a, b));
}

#endif // C0067_H
