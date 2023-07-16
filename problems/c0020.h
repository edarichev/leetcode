/*
20. Valid Parentheses
Easy
20.8K
1.3K
Companies
Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

An input string is valid if:

Open brackets must be closed by the same type of brackets.
Open brackets must be closed in the correct order.
Every close bracket has a corresponding open bracket of the same type.


Example 1:

Input: s = "()"
Output: true
Example 2:

Input: s = "()[]{}"
Output: true
Example 3:

Input: s = "(]"
Output: false


Constraints:

1 <= s.length <= 104
s consists of parentheses only '()[]{}'.
 */
#ifndef C0020_H
#define C0020_H

#include "global.h"

static const int _=[]{ios::sync_with_stdio(false);cin.tie(nullptr);cout.tie(nullptr);return 0;}();

class Solution {
public:
        bool isValid(string s) {
        stack<char> parenth;
        for (char c : s) {
            switch (c) {
            case '(':
            case '[':
            case '{':
                parenth.push(c);
                continue;
            case ')':
                if (parenth.empty() || parenth.top() != '(')
                    return false;
                break;
            case ']':
                if (parenth.empty() || parenth.top() != '[')
                    return false;
                break;
            case '}':
                if (parenth.empty() || parenth.top() != '{')
                    return false;
                break;
            default:
                continue;
            }
            parenth.pop();
        }
        return parenth.empty();
    }
};

void test()
{
    string s = "()[]{})";
    Solution sl;
    cout << sl.isValid(s);
}

#endif // C0020_H
