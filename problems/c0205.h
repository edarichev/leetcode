/*
205. Isomorphic Strings
Easy
7.1K
1.5K
Companies
Given two strings s and t, determine if they are isomorphic.

Two strings s and t are isomorphic if the characters in s can be replaced to get t.

All occurrences of a character must be replaced with another character while preserving the order of characters. No two characters may map to the same character, but a character may map to itself.



Example 1:

Input: s = "egg", t = "add"
Output: true
Example 2:

Input: s = "foo", t = "bar"
Output: false
Example 3:

Input: s = "paper", t = "title"
Output: true


Constraints:

1 <= s.length <= 5 * 104
t.length == s.length
s and t consist of any valid ascii character.
 */
#ifndef C0205_H
#define C0205_H

#include "global.h"

static const int _=[]{ios::sync_with_stdio(false);cin.tie(nullptr);cout.tie(nullptr);return 0;}();

class Solution {
public:
    bool isIsomorphic1(string s, string t) {
        // это решение экономнее, если unicode
        if (s.length() != s.length())
            return false;
        map<char, char> cx;
        for (size_t i = 0; i < s.length(); i++) {
            char c1 = s[i];
            char c2 = t[i];
            if (cx.find(c1) == cx.end()) {
                if (cx.end() != find_if(cx.begin(), cx.end(), [&c2](map<char, char>::value_type &v) { return c2 == v.second;}))
                    return false;
                cx[c1] = c2;
                continue;
            }
            if (cx[c1] != c2)
                return false;
        }
        return true;
    }

    bool isIsomorphic(string s, string t) {
        if (s.length() != s.length())
            return false;
        char m[256]{}; // индекс - код символа в s, значение - код в t
        // изначально - нули
        for (size_t i = 0; i < s.length(); i++) {
            char c1 = s[i];
            char c2 = t[i];
            char ax = m[(int)c1];
            if (ax == 0) {
                for (auto x : m) {
                    if (x == c2)
                        return false;
                }
                m[(int)c1] = c2;
                continue;
            }
            if (ax != c2)
                return false;
        }
        return true;
    }
};

void test()
{
    string s = "badc", t = "baba";
    cout << Solution().isIsomorphic(s, t);
}

#endif // C0205_H
