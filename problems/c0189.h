/*
189. Rotate Array
Medium
14.9K
1.7K
Companies
Given an integer array nums, rotate the array to the right by k steps, where k is non-negative.



Example 1:

Input: nums = [1,2,3,4,5,6,7], k = 3
Output: [5,6,7,1,2,3,4]
Explanation:
rotate 1 steps to the right: [7,1,2,3,4,5,6]
rotate 2 steps to the right: [6,7,1,2,3,4,5]
rotate 3 steps to the right: [5,6,7,1,2,3,4]
Example 2:

Input: nums = [-1,-100,3,99], k = 2
Output: [3,99,-1,-100]
Explanation:
rotate 1 steps to the right: [99,-1,-100,3]
rotate 2 steps to the right: [3,99,-1,-100]


Constraints:

1 <= nums.length <= 105
-231 <= nums[i] <= 231 - 1
0 <= k <= 105
 */
#ifndef C0189_H
#define C0189_H

#include "global.h"

class Solution {
public:
    void rotate1(vector<int>& nums, int k) {
        // медленнее, но меньше памяти
        k = k % nums.size();
        if (nums.size() < 2 || k == 0)
            return;
        ios_base::sync_with_stdio(false);
        vector<int> v(k);
        std::copy(nums.end() - k, nums.end(), v.begin());
        std::copy(nums.begin(), nums.end() - k, nums.begin() + k);
        std::copy(v.begin(), v.end(), nums.begin());
    }

    void rotate(vector<int>& nums, int k) {
        // быстрее, но больше памяти
        int n = nums.size();
        k = k % n;
        if (n < 2 || k == 0)
            return;
        ios_base::sync_with_stdio(false);
        vector<int> v(n);
        for (int i = 0; i < n; i++) {
            if (i < k) { // из конца массива
                v[i] = nums[n - k + i];
            } else { // из начала массива
                v[i] = nums[i - k];
            }
        }
        nums = v;
    }
};

void test()
{
    vector<int> nums = {1,2,3,4,5,6,7};
    int k = 3;
    Solution s;
    s.rotate(nums, k);
    printV(nums);
}

#endif // C0189_H
