#ifndef P1_1_19_H
#define P1_1_19_H

#include "../helpers.h"

using namespace std;

class Solution
{
public:

    static long F(long n)
    {
        std::vector<long> fnum;
        fnum.reserve(n+1);
        fnum.push_back(0);
        fnum.push_back(1);
        for (long i = 2; i <= n; i++) {
            long c2 = *prev(prev(fnum.end()));
            long c1 = *prev(fnum.end());
            long cx = c1 + c2;
            fnum.push_back(cx);
        }
        return fnum.back();
    }

    static void test()
    {
        long x = F(10);
        assert(x == 55);
    }
};

#endif // P1_1_19_H
