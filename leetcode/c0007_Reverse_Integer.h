/*
7. Reverse Integer
Medium
Topics
Companies
Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go outside the signed 32-bit integer range [-231, 231 - 1], then return 0.

Assume the environment does not allow you to store 64-bit integers (signed or unsigned).



Example 1:

Input: x = 123
Output: 321
Example 2:

Input: x = -123
Output: -321
Example 3:

Input: x = 120
Output: 21


Constraints:

-231 <= x <= 231 - 1
 */
#ifndef C0007_REVERSE_INTEGER_H
#define C0007_REVERSE_INTEGER_H

#include "global.h"

static int _=[](){ios_base::sync_with_stdio(false);return 0;}();

class Solution {
public:
    int reverse(int x) {
        int k = 0;
        const int IMAX = 2147483647;
        const int IMIN = -2147483648;
        // 2147483647 -> 7463847412
        while (x) {
            int n = x % 10;
            if (k >= IMAX / 10) {
                if (k > IMAX / 10)
                    return 0;
                else if (n > 7)
                        return 0;
            }
            if (k < IMIN / 10) {
                if (k < IMIN / 10)
                    return 0;
                else if (n < -8)
                    return 0;
            }
            x /= 10;
            k *= 10;
            k += n;
        }
        return k;
    }
};

void test()
{
    assert(Solution().reverse(123) == 321);
    assert(Solution().reverse(-123) == -321);
    assert(Solution().reverse(2147483647) == 0);
    assert(Solution().reverse(-2147483412) == -2143847412);
    assert(Solution().reverse(-2147483648) == 0);
}

#endif // C0007_REVERSE_INTEGER_H
