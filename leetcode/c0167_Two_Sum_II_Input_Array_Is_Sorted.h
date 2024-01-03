/*
167. Two Sum II - Input Array Is Sorted
Medium
10.1K
1.3K
Companies
Given a 1-indexed array of integers numbers that is already sorted in non-decreasing order, find two numbers such that they add up to a specific target number. Let these two numbers be numbers[index1] and numbers[index2] where 1 <= index1 < index2 < numbers.length.

Return the indices of the two numbers, index1 and index2, added by one as an integer array [index1, index2] of length 2.

The tests are generated such that there is exactly one solution. You may not use the same element twice.

Your solution must use only constant extra space.



Example 1:

Input: numbers = [2,7,11,15], target = 9
Output: [1,2]
Explanation: The sum of 2 and 7 is 9. Therefore, index1 = 1, index2 = 2. We return [1, 2].
Example 2:

Input: numbers = [2,3,4], target = 6
Output: [1,3]
Explanation: The sum of 2 and 4 is 6. Therefore index1 = 1, index2 = 3. We return [1, 3].
Example 3:

Input: numbers = [-1,0], target = -1
Output: [1,2]
Explanation: The sum of -1 and 0 is -1. Therefore index1 = 1, index2 = 2. We return [1, 2].


Constraints:

2 <= numbers.length <= 3 * 104
-1000 <= numbers[i] <= 1000
numbers is sorted in non-decreasing order.
-1000 <= target <= 1000
The tests are generated such that there is exactly one solution.
 */
#ifndef C0167_TWO_SUM_II_INPUT_ARRAY_IS_SORTED_H
#define C0167_TWO_SUM_II_INPUT_ARRAY_IS_SORTED_H

#include "global.h"

static int _ = [](){ios_base::sync_with_stdio(false); return 0;}();

class Solution {
public:
    // 7 ms, 15,52mb, O(n log n)
    vector<int> twoSum(vector<int>& numbers, int target) {
        vector<int> result;
        for (size_t i = 0; i < numbers.size(); i++) {
            int v = target - numbers[i];
            auto it = std::lower_bound(numbers.begin() + i + 1, numbers.end(), v);
            if (it == numbers.end())
                continue;
            if (*it != v)
                continue;
            result.push_back(i + 1);
            result.push_back(std::distance(numbers.begin(), it) + 1);
            break;
        }
        return result;
    }
};

void test()
{
    vector<int> numbers = {2,7,11,15}; int target = 9;
    Solution s;
    printV(s.twoSum(numbers, target));
    numbers = {2,3,4}, target = 6;
    printV(s.twoSum(numbers, target));
    numbers = {-1,0}, target = -1;
    printV(s.twoSum(numbers, target));
}

#endif // C0167_TWO_SUM_II_INPUT_ARRAY_IS_SORTED_H
