/*
1. Two Sum
Solved
Easy
Topics
Companies
Hint
Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

You can return the answer in any order.



Example 1:

Input: nums = [2,7,11,15], target = 9
Output: [0,1]
Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
Example 2:

Input: nums = [3,2,4], target = 6
Output: [1,2]
Example 3:

Input: nums = [3,3], target = 6
Output: [0,1]


Constraints:

2 <= nums.length <= 104
-109 <= nums[i] <= 109
-109 <= target <= 109
Only one valid answer exists.


Follow-up: Can you come up with an algorithm that is less than O(n2) time complexity?
Accepted
11.3M
Submissions
22.1M
Acceptance Rate
51.0%
 */
#ifndef C0001_TWO_SUM_H
#define C0001_TWO_SUM_H

#include "global.h"

static int _ = [](){ ios_base::sync_with_stdio(false); return 0;}();

class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        vector<int> result;
        // здесь: ключ == target - nums[i]
        // значение == индекс i, с которым будет достигнута сумма
        // тогда второй индекс - из текущего цикла, а второй - из предыдущего вычисления в кэше
        map<int, int> cache;
        for (size_t i = 0; i < nums.size(); ++i) {
            if (cache.count(nums[i])) { // если такое число было вычислено ранее, то в качестве значения будет его индекс
                result.push_back(cache[nums[i]]);
                result.push_back(i);
                break;
            }
            cache[target - nums[i]] = i;
        }
        return result;
    }
};

#endif // C0001_TWO_SUM_H
