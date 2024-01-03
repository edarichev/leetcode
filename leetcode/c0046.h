/*
46. Permutations
Medium
16.2K
262
Companies
Given an array nums of distinct integers, return all the possible permutations. You can return the answer in any order.



Example 1:

Input: nums = [1,2,3]
Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
Example 2:

Input: nums = [0,1]
Output: [[0,1],[1,0]]
Example 3:

Input: nums = [1]
Output: [[1]]


Constraints:

1 <= nums.length <= 6
-10 <= nums[i] <= 10
All the integers of nums are unique.
 */
#ifndef C0046_H
#define C0046_H

#include "global.h"



class Solution {
public:
    vector<vector<int>> permute(vector<int>& nums) {
        vector<vector<int>> result;
        perm(result, nums, 0);
        return result;
    }

    void perm(vector<vector<int>> &result, vector<int>& nums, size_t i)
    {
        if (i == nums.size()) {
            result.push_back(nums);
            return;
        }
        for (size_t j = i; j < nums.size(); j++) {
            std::swap(nums[i], nums[j]);
            perm(result, nums, i + 1);
            std::swap(nums[i], nums[j]);
        }
    }
};


void test()
{
    Solution s;
    vector<int> p {1, 2, 3};
    auto r = s.permute(p);
    printV2<int>(r);
}

#endif // C0046_H
