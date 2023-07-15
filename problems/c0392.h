/*
392. Is Subsequence
Easy
7.8K
433
Companies
Given two strings s and t, return true if s is a subsequence of t, or false otherwise.

A subsequence of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., "ace" is a subsequence of "abcde" while "aec" is not).



Example 1:

Input: s = "abc", t = "ahbgdc"
Output: true
Example 2:

Input: s = "axc", t = "ahbgdc"
Output: false


Constraints:

0 <= s.length <= 100
0 <= t.length <= 104
s and t consist only of lowercase English letters.


Follow up: Suppose there are lots of incoming s, say s1, s2, ..., sk where k >= 109, and you want to check one by one to see if t has its subsequence. In this scenario, how would you change your code?
 */
#ifndef C0392_H
#define C0392_H

#include "global.h"

static int _ = [](){ ios_base::sync_with_stdio(false); return 0;}();

class Solution {
public:
    bool isSubsequence(const string &s, const string &t) {
        size_t n = s.length(), m = t.length();
        if (!m && !n)
            return true;
        if (!n) // пустая может быть
            return true;
        if (n > m)
            return false;
        size_t i = 0; // индекс в s
        char c = s[i];
        // проходим по t, находим букву и увеличивем i
        for (size_t j = 0; j < m; j++) {
            if (t[j] == c) {
                i++;
                if (i == n)
                    return true;
                c = s[i];
            }
        }
        return false;
    }
};

void test()
{
    string s = "abc", t = "ahbgdc";
    Solution sl;
    assert(sl.isSubsequence(s, t));
}

#endif // C0392_H
