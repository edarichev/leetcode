/*
118. Pascal's Triangle
Easy
10.5K
338
Companies
Given an integer numRows, return the first numRows of Pascal's triangle.

In Pascal's triangle, each number is the sum of the two numbers directly above it as shown:
@file PascalTriangleAnimated2.gif



Example 1:

Input: numRows = 5
Output: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
Example 2:

Input: numRows = 1
Output: [[1]]


Constraints:

1 <= numRows <= 30
 */
#ifndef C0118_H
#define C0118_H

#include "global.h"

class Solution {
public:
    vector<vector<int>> generate(int numRows) {
        vector<vector<int>> result;
        if (numRows >= 1) {
            result.emplace_back(vector<int>{1});
        }
        if (numRows < 2)
            return result;
        for (int rowNumber = 2; rowNumber <= numRows; rowNumber++) {
            vector<int> row(rowNumber);
            row[0] = 1;
            row.back() = 1;
            for (int j = 1; j < rowNumber - 1; j++) {
                auto &c = result[rowNumber - 1 - 1]; // -1, т.к. с 1 считаем
                int sum = c[j-1] + c[j];
                row[j] = sum;
            }
            result.push_back(row); // почему-то это быстрее, чем emplace/move
        }
        return result;
    }
};

void test()
{
    Solution s;
    auto t = s.generate(5);
    printV2(t);
}

#endif // C0118_H
