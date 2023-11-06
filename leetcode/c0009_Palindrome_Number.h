/*
Given an integer x, return true if x is a
palindrome
, and false otherwise.



Example 1:

Input: x = 121
Output: true
Explanation: 121 reads as 121 from left to right and from right to left.
Example 2:

Input: x = -121
Output: false
Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.
Example 3:

Input: x = 10
Output: false
Explanation: Reads 01 from right to left. Therefore it is not a palindrome.


Constraints:

-2^31 <= x <= 2^31 - 1


Follow up: Could you solve it without converting the integer to a string?
 */
#ifndef C0009_PALINDROME_NUMBER_H
#define C0009_PALINDROME_NUMBER_H

#include "global.h"

static const int _ = [](){ios::sync_with_stdio(false);cin.tie(nullptr);cout.tie(nullptr);return 0;}();

class Solution {
public:
    bool isPalindrome(int x) {
        if (x < 0)
            return false;
        long long c = 0;
        long long a = x;
        while (x) {
            c = c * 10 + x % 10;
            x /= 10;
        }
        return c == a;
    }
};

void test()
{
    assert(Solution().isPalindrome(-121) == false);
    assert(Solution().isPalindrome(10) == false);
    assert(Solution().isPalindrome(121) == true);
    assert(Solution().isPalindrome(998765432) == false);
}

#endif // C0009_PALINDROME_NUMBER_H
