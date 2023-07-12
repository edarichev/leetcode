/*
275. H-Index II
Medium
122
20
Companies
Given an array of integers citations where citations[i] is the number of citations a researcher received for their ith paper and citations is sorted in ascending order, return the researcher's h-index.

According to the definition of h-index on Wikipedia: The h-index is defined as the maximum value of h such that the given researcher has published at least h papers that have each been cited at least h times.

You must write an algorithm that runs in logarithmic time.



Example 1:

Input: citations = [0,1,3,5,6]
Output: 3
Explanation: [0,1,3,5,6] means the researcher has 5 papers in total and each of them had received 0, 1, 3, 5, 6 citations respectively.
Since the researcher has 3 papers with at least 3 citations each and the remaining two with no more than 3 citations each, their h-index is 3.
Example 2:

Input: citations = [1,2,100]
Output: 2


Constraints:

n == citations.length
1 <= n <= 105
0 <= citations[i] <= 1000
citations is sorted in ascending order.
 */
#ifndef C0275_H
#define C0275_H

#include "global.h"

class Solution {
public:
    int hIndex(vector<int>& citations) {
        ios_base::sync_with_stdio(false);
        int n = citations.size();
        if (n == 0)
            return 0;
        if (n == 1)
            return citations[0] == 0 ? 0 : 1;
        int left = 0;
        int right = n - 1;
        int h=0;
        while (left <= right) {
            int mid = (left + right) / 2;
            if (n - mid <= citations[mid]) {
                h = n - mid;
                right = mid - 1;
            }
            else{
                left = mid + 1;
            }
        }
        return h;
    }
};

void test()
{
    vector<int> citations = {0,1,3,5,6};
    Solution s;
    assert(3 == s.hIndex(citations));
    citations = {1,2,100};
    assert(2 == s.hIndex(citations));
    citations = {0,0};
    assert(0 == s.hIndex(citations));
    citations = {100};
    assert(1 == s.hIndex(citations));
    citations = {1,2};
    assert(1 == s.hIndex(citations));
}

#endif // C0275_H
