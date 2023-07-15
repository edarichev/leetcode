/*
125. Valid Palindrome
Easy
7.4K
7.4K
Companies
A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.

Given a string s, return true if it is a palindrome, or false otherwise.



Example 1:

Input: s = "A man, a plan, a canal: Panama"
Output: true
Explanation: "amanaplanacanalpanama" is a palindrome.
Example 2:

Input: s = "race a car"
Output: false
Explanation: "raceacar" is not a palindrome.
Example 3:

Input: s = " "
Output: true
Explanation: s is an empty string "" after removing non-alphanumeric characters.
Since an empty string reads the same forward and backward, it is a palindrome.


Constraints:

1 <= s.length <= 2 * 105
s consists only of printable ASCII characters.
 */

#ifndef C0125_H
#define C0125_H

#include "global.h"

static int _ = [](){ios_base::sync_with_stdio(false) ;return 0;}();

class Solution {
public:
    bool isPalindrome(const string &s) {
        size_t n = s.length();
        if (n < 2)
            return true;
        string p;
        p.reserve(n);
        for (size_t i = 0; i < n; i++) {
            char c = s[i];
            if (isalnum(c)) {
                p.push_back(tolower(c));
            }
            /* а так - медленнее
            if ((c <= 'z' && c >= 'a') || (c <= '9' && c >= '0')) {
                p.push_back(c);
            } else if (c <= 'Z' && c >= 'A') {
                p.push_back(c + ('a' - 'A'));
            }*/
        }
        string k = p;
        std::reverse(k.begin(), k.end());
        return k == p;
    }
};

void test()
{
    string s = "A man, a plan, a canal: Panama";
    Solution sl;
    assert(sl.isPalindrome(s));
}

#endif // C0125_H
