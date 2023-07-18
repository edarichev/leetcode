/*

 */
#ifndef C0069_SQRT_H
#define C0069_SQRT_H

#include "global.h"

static int _ = [](){ ios_base::sync_with_stdio(false); return 0;}();

class Solution {
public:
    int mySqrt(int x) {
        // метод Ньютона
        double e = 1E-2;// так быстрее
        double n = 1;
        while (std::abs(n*n - x) > e) {
            n = (n + x / n) / 2;
        }
        return (int)n;
    }
};

void test()
{
    Solution s;
    cout << s.mySqrt(16);
}
#endif // C0069_SQRT_H
