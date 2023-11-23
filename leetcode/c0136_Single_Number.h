/*
Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.

You must implement a solution with a linear runtime complexity and use only constant extra space.



Example 1:

Input: nums = [2,2,1]
Output: 1
Example 2:

Input: nums = [4,1,2,1,2]
Output: 4
Example 3:

Input: nums = [1]
Output: 1


Constraints:

1 <= nums.length <= 3 * 104
-3 * 104 <= nums[i] <= 3 * 104
Each element in the array appears twice except for one element which appears only once.

 */
#ifndef C0136_SINGLE_NUMBER_H
#define C0136_SINGLE_NUMBER_H

#include "global.h"

static int _ = [](){ios_base::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr);return 0;}();

class Solution {
public:
    int singleNumber_sort(vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        // кол-во элементов, если следовать условию, нечётное
        for (size_t i = 0; i < nums.size() - 1; i += 2) {
            if (nums[i] != nums[i + 1])
                return nums[i];
        }
        return nums.back();
    }
    int singleNumber(vector<int>& nums) {
        // если дважды взять XOR одного числа, оно станет равно 0
        //  01010101
        // ^01010101
        // =00000000 (типа xor rax, rax ; -> 0)
        // но если число встретилось нечётное число раз, то с нулём:
        //  00000000
        // ^11001100
        // =11001100
        // оно останется как есть
        int a = 0;
        for (int x : nums)
            a ^= x;
        return a;
    }
};

void test()
{
    vector v{2,2,1};
    assert(Solution().singleNumber(v) == 1);
    vector v2{4,1,2,1,2};
    assert(Solution().singleNumber(v2) == 4);
    vector v3{1};
    assert(Solution().singleNumber(v3) == 1);
}
#endif // C0136_SINGLE_NUMBER_H
