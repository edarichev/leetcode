#ifndef P1_1_20_H
#define P1_1_20_H

#include "../helpers.h"
#include <cmath>

class Solution
{
public:
    static double ln(double x)
    {
        return ::log(x);
    }

    static long fact(long x)
    {
        if (x == 0)
            return 1;
        return x * fact(x - 1);
    }

    static void test()
    {
        double e = 1.0E-5;
        assert(abs(ln(fact(10)) - 15.104412573) <= e);
    }
};

#endif // P1_1_20_H
