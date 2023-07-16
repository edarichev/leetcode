/*
290. Word Pattern
Easy
6.5K
785
Companies
Given a pattern and a string s, find if s follows the same pattern.

Here follow means a full match, such that there is a bijection between a letter in pattern and a non-empty word in s.



Example 1:

Input: pattern = "abba", s = "dog cat cat dog"
Output: true
Example 2:

Input: pattern = "abba", s = "dog cat cat fish"
Output: false
Example 3:

Input: pattern = "aaaa", s = "dog cat cat dog"
Output: false


Constraints:

1 <= pattern.length <= 300
pattern contains only lower-case English letters.
1 <= s.length <= 3000
s contains only lowercase English letters and spaces ' '.
s does not contain any leading or trailing spaces.
All the words in s are separated by a single space.
 */
#ifndef C0290_H
#define C0290_H

#include "global.h"


static int _ = [](){ ios_base::sync_with_stdio(false); return 0;}();

class Solution {
public:

    bool containsValue(const map<char, string> &cx, const string &v)
    {
        return cx.end() != find_if(cx.begin(), cx.end(), [&v](const map<char, string>::value_type &p) { return p.second == v;});
    }

    bool wordPattern(const string &pattern, const string &s) {
        map<char, string> cx; // chars in pattern
        char *saveptr;
        char *p = strtok_r((char*)s.c_str(), " ", &saveptr);
        for (auto c : pattern) {
            if (!p)
                return false;
            string w(p);
            if (cx.find(c) == cx.end()) {
                // символа ещё нет
                if (containsValue(cx, w))
                    return false; // т.к. есть совпадение, и тогда не по шаблону
                cx.insert({c, w});
                p = strtok_r(NULL, " ", &saveptr);
                continue;
            }
            // символ уже есть
            if (cx[c] != w)
                return false;
            p = strtok_r(NULL, " ", &saveptr);
        }
        if (p)
            return false;
        return true;
    }
};

void test()
{
    string pattern = "abba", s = "dog cat cat dog";
    Solution sl;
    cout << sl.wordPattern(pattern, s);
    ;
}

#endif // C0290_H
