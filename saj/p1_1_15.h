#ifndef P1_1_15_H
#define P1_1_15_H

#include "../helpers.h"

class Solution
{
public:
    vector<int> histogram(const vector<int> &a, int M)
    {
        vector<int> h(M);
        for (auto c : a) {
            if (c >= 0 && c < M)
                h[c]++;
        }
        return h;
    }

    static void test()
    {
        vector<int> v = {1, 4, 5, 67, 78, 4, 5, 5, 3, 4, 2, 1, 6};
        int M = 6;
        Solution s;
        auto ret = s.histogram(v, M);
        vector<int> t({0,2,1,1,3,3});
        assert(t == ret);
    }
};

#endif // P1_1_15_H
