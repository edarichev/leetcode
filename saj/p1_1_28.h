#ifndef P1_1_28_H
#define P1_1_28_H

#include "helpers.h"

class Solution
{
public:
    static void removeDuplicates(vector<int> &v)
    {
        if (v.empty())
            return;
        // два индекса: с шагом 1 и второй ищет следующий не повторяющийся

        int prev = v[0];
        size_t i = 1, j = 1;
        for (; j < v.size(); i++) {
            while (j < v.size() && prev == v[j])
                j++;
            if (j == v.size())
                break;
            v[i] = v[j];
            prev = v[i];
        }
        v.erase(v.begin() + i, v.end());
        v.shrink_to_fit();
    }
    static void test()
    {
        vector<int> v {1,2,2,2,3,3,3,4,4,4,4,5,5,5,5};
        vector<int> v_test {1,2,3,4,5};
        removeDuplicates(v);
        printV(v);
        assert(v == v_test);
    }
};

#endif // P1_1_28_H
