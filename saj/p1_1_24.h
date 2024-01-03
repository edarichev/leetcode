#ifndef P1_1_24_H
#define P1_1_24_H

#include "../helpers.h"
#include <numeric>

class Solution
{
public:
    static int gcd(int p, int q)
    {
        cout << "p=" << p << " q=" << q << endl;
        if (q == 0) {
            return p;
        }
        return gcd(q, p % q);
    }
    static void test()
    {
        assert(Solution::gcd(105, 24) == std::gcd(105, 24));
        assert(Solution::gcd(1111111, 1234567) == std::gcd(1111111, 1234567));
    }
};

#endif // P1_1_24_H
