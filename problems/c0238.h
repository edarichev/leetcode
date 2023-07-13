/*
238. Product of Array Except Self
Medium
18.6K
1K
Companies
Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].

The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.

You must write an algorithm that runs in O(n) time and without using the division operation.



Example 1:

Input: nums = [1,2,3,4]
Output: [24,12,8,6]
Example 2:

Input: nums = [-1,1,0,-3,3]
Output: [0,0,9,0,0]


Constraints:

2 <= nums.length <= 105
-30 <= nums[i] <= 30
The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.


Follow up: Can you solve the problem in O(1) extra space complexity? (The output array does not count as extra space for space complexity analysis.)
 */
#ifndef C0238_H
#define C0238_H

#include "global.h"

static const int _=[]{ios::sync_with_stdio(false);cin.tie(nullptr);cout.tie(nullptr);return 0;}();

class Solution {
public:
    vector<int> productExceptSelf(vector<int>& nums) {
        int n = nums.size();

        vector<int> r(n, 1);
        /*
        for (int i = 1; i < n; i++) {
            r[i] = nums[i - 1] * r[i - 1];
        }

        int f = 1;
        for (int i = nums.size() - 1; i >= 0; i--) {
            r[i] *= f;
            f *= nums[i];
        }*/
        for (int i = 1; i < n; i++) {
            r[i] = nums[i - 1] * r[i - 1];
        }
        int f = 1;
        for (int i = n - 1; i >= 0; i--) {
            r[i] *= f;
            f *= nums[i];
        }
        return r;
    }
};

void test()
{
    vector<int> nums = {1,2,3,4};
    vector<int> t1 = {24,12,8,6};
    Solution s;
    vector<int> r1 = s.productExceptSelf(nums);
    printV(r1);
    nums = {-1,1,0,-3,3};
    vector<int> t2 = {0,0,9,0,0};
}

#endif // C0238_H
