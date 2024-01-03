/*
274. H-Index
Medium
359
97
Companies
Given an array of integers citations where citations[i] is the number of citations a researcher received for their ith paper, return the researcher's h-index.

According to the definition of h-index on Wikipedia: The h-index is defined as the maximum value of h such that the given researcher has published at least h papers that have each been cited at least h times.



Example 1:

Input: citations = [3,0,6,1,5]
Output: 3
Explanation: [3,0,6,1,5] means the researcher has 5 papers in total and each of them had received 3, 0, 6, 1, 5 citations respectively.
Since the researcher has 3 papers with at least 3 citations each and the remaining two with no more than 3 citations each, their h-index is 3.
Example 2:

Input: citations = [1,3,1]
Output: 1


Constraints:

n == citations.length
1 <= n <= 5000
0 <= citations[i] <= 1000
 */
#ifndef C0274_H
#define C0274_H

#include "global.h"

class Solution {
public:
    int hIndex(vector<int>& citations) {
        int n = citations.size();
        if (n == 0)
            return 0;
        /* учёный с индексом h опубликовал как минимум h статей, на каждую из
         * которых сослались как минимум h раз.
         * Для определения индекса Хирша рассматриваемые статьи располагают в
         * порядке уменьшения числа ссылок на них.
         * Далее из тех статей, номер которых не превосходит число их
         * цитирований, находят последнюю. Номер этой статьи и есть индекс Хирша.
         */
        std::sort(citations.begin(), citations.end(), greater<int>());
        int i = 0;
        for (; i < n; i++) {
            if (i+1 > citations[i])
                break;
        }
        return i;
    }
};

void test()
{
    vector<int> citations = {3,0,6,1,5};//{1, 3, 1}; //;
    Solution s;
    cout << s.hIndex(citations) << endl;
    citations = {1, 3, 1};
    cout << s.hIndex(citations) << endl;
    citations = {100};
    cout << s.hIndex(citations) << endl;
}

#endif // C0274_H
