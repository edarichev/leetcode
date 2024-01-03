/*
66. Plus One
Easy
Topics
Companies
You are given a large integer represented as an integer array digits, where each digits[i] is the ith digit of the integer. The digits are ordered from most significant to least significant in left-to-right order. The large integer does not contain any leading 0's.

Increment the large integer by one and return the resulting array of digits.



Example 1:

Input: digits = [1,2,3]
Output: [1,2,4]
Explanation: The array represents the integer 123.
Incrementing by one gives 123 + 1 = 124.
Thus, the result should be [1,2,4].
Example 2:

Input: digits = [4,3,2,1]
Output: [4,3,2,2]
Explanation: The array represents the integer 4321.
Incrementing by one gives 4321 + 1 = 4322.
Thus, the result should be [4,3,2,2].
Example 3:

Input: digits = [9]
Output: [1,0]
Explanation: The array represents the integer 9.
Incrementing by one gives 9 + 1 = 10.
Thus, the result should be [1,0].


Constraints:

1 <= digits.length <= 100
0 <= digits[i] <= 9
digits does not contain any leading 0's.
 */
#ifndef C0066_PLUS_ONE_H
#define C0066_PLUS_ONE_H

#include "helpers.h"

static int _ = [](){ios::sync_with_stdio(false);cin.tie(nullptr);cout.tie(nullptr);return 0;}();

class Solution {
public:
    vector<int> plusOne(vector<int>& digits) {
        int c = digits.back() + 1;
        if (c < 10) {
            digits.back()++;
            return digits;
        }
        digits.back() = 0;
        // есть перенос
        c = 1;
        for (auto it = next(digits.rbegin()); it != digits.rend(); ++it) {
            int x = *it + c;
            if (x < 10) {
                c = 0;
                *it = x;
                break;
            } else {
                *it = 0;
                c = 1;
            }
        }
        if (c == 1) {
            digits.insert(digits.begin(), 1);
        }
        return digits;
    }
};

void test()
{
    vector<int> v1 {1, 2, 3};
    vector<int> v_1 {1, 2, 4};
    assert(Solution().plusOne(v1) == v_1);

    vector<int> v2 {9, 9, 9};
    vector<int> v_2 {1, 0, 0, 0};
    assert(Solution().plusOne(v2) == v_2);
}
#endif // C0066_PLUS_ONE_H
