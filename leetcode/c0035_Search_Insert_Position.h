/*
35. Search Insert Position
Easy
Topics
Companies
Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

You must write an algorithm with O(log n) runtime complexity.



Example 1:

Input: nums = [1,3,5,6], target = 5
Output: 2
Example 2:

Input: nums = [1,3,5,6], target = 2
Output: 1
Example 3:

Input: nums = [1,3,5,6], target = 7
Output: 4


Constraints:

1 <= nums.length <= 104
-104 <= nums[i] <= 104
nums contains distinct values sorted in ascending order.
-104 <= target <= 104
 */
#ifndef C0035_SEARCH_INSERT_POSITION_H
#define C0035_SEARCH_INSERT_POSITION_H

#include "helpers.h"

static int _ = [](){ios_base::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr);return 0;}();

class Solution {
public:
    int searchInsert(vector<int>& nums, int target) {
        // краевые условия
        if (!nums.size() || nums[0] > target)
            return 0;
        if (nums.back() < target)
            return nums.size();
        // бинарный поиск тут не поможет, т.к. мы перепрыгнем через нужное место
        // поэтому двигаемся методом половинного деления
        int lo = 0;
        int hi = nums.size();
        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2;
            if (nums[mid] < target)
                lo = mid + 1;
            else if (nums[mid] > target) {
                hi = mid - 1;
            }
            else
                return mid;
        }
        return lo;
    }
};

void test()
{
    vector<int> v1 {1,3,5,6};
    assert(Solution().searchInsert(v1, 5) == 2);
    assert(Solution().searchInsert(v1, 2) == 1);

    assert(Solution().searchInsert(v1, 7) == 4);
    vector<int> v2 {1,3};
    int i = Solution().searchInsert(v2, 2);
    assert(i == 1);
}

#endif // C0035_SEARCH_INSERT_POSITION_H
