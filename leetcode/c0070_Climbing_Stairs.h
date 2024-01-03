/*

Easy
Topics
Companies
Hint
You are climbing a staircase. It takes n steps to reach the top.

Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?



Example 1:

Input: n = 2
Output: 2
Explanation: There are two ways to climb to the top.
1. 1 step + 1 step
2. 2 steps
Example 2:

Input: n = 3
Output: 3
Explanation: There are three ways to climb to the top.
1. 1 step + 1 step + 1 step
2. 1 step + 2 steps
3. 2 steps + 1 step


Constraints:

1 <= n <= 45

Hint 1
To reach nth step, what could have been your previous steps? (Think about the step sizes)

 */
#ifndef C0070_CLIMBING_STAIRS_H
#define C0070_CLIMBING_STAIRS_H

#include "global.h"

static int _ = [](){ ios_base::sync_with_stdio(false); return 0;}();


class Solution {
public:
    int climbStairs(int n) {
        // на 1 ступеньку: 1 способ
        // на 2 ступеньки: 2 способа
        // на 3 --//--   : 3=2+1
        // на 4          : 5=3+2
        //    5          : 8=3+5
        // == сумме двух предыдущих
        if (n == 1)
            return 1;
        if (n == 2)
            return 2;
        int a = 1;
        int b = 2;
        int c = a + b;
        for (int i = 3; i <= n; i++) {
            c = a + b;
            a = b;
            b = c;
        }
        return c;
    }
};

void test()
{
    auto x1 = Solution().climbStairs(2);
    assert(x1 == 2);
    assert(Solution().climbStairs(3) == 3);
}

#endif // C0070_CLIMBING_STAIRS_H
