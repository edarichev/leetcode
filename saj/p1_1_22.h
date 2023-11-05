#ifndef P1_1_22_H
#define P1_1_22_H

#include "../helpers.h"

class Solution
{
public:
    static int rank(const std::vector<int> &a, int v)
    {
        return rank(a, v, 0, a.size() - 1, 0);
    }
    static int rank(const std::vector<int> &a, int v, size_t lo, size_t hi, int level)
    {
        if (lo > hi)
            return -1;
        string st(level, ' ');
        cout << st << lo << " " << hi << endl;
        int mid = lo + (hi - lo)/2;
        if (v < a[mid])
            return rank(a, v, lo, mid - 1, level + 1);
        else if (v > a[mid])
            return rank(a, v, mid + 1, hi, level + 1);
        return mid;
    }
    static void test()
    {
        std::vector<int> a{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
        assert(rank(a, 5) == 4);
    }
};

#endif // P1_1_22_H
