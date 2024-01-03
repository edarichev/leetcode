/*
27. Remove Element
Easy
476
517
Companies
Given an integer array nums and an integer val, remove all occurrences of val in nums in-place. The order of the elements may be changed. Then return the number of elements in nums which are not equal to val.

Consider the number of elements in nums which are not equal to val be k, to get accepted, you need to do the following things:

Change the array nums such that the first k elements of nums contain the elements which are not equal to val. The remaining elements of nums are not important as well as the size of nums.
Return k.
Custom Judge:

The judge will test your solution with the following code:

int[] nums = [...]; // Input array
int val = ...; // Value to remove
int[] expectedNums = [...]; // The expected answer with correct length.
                            // It is sorted with no values equaling val.

int k = removeElement(nums, val); // Calls your implementation

assert k == expectedNums.length;
sort(nums, 0, k); // Sort the first k elements of nums
for (int i = 0; i < actualLength; i++) {
    assert nums[i] == expectedNums[i];
}
If all assertions pass, then your solution will be accepted.



Example 1:

Input: nums = [3,2,2,3], val = 3
Output: 2, nums = [2,2,_,_]
Explanation: Your function should return k = 2, with the first two elements of nums being 2.
It does not matter what you leave beyond the returned k (hence they are underscores).
Example 2:

Input: nums = [0,1,2,2,3,0,4,2], val = 2
Output: 5, nums = [0,1,4,0,3,_,_,_]
Explanation: Your function should return k = 5, with the first five elements of nums containing 0, 0, 1, 3, and 4.
Note that the five elements can be returned in any order.
It does not matter what you leave beyond the returned k (hence they are underscores).


Constraints:

0 <= nums.length <= 100
0 <= nums[i] <= 50
0 <= val <= 100
 */

#ifndef C0027_H
#define C0027_H

#include "global.h"

class Solution {
public:
    int removeElement1(vector<int>& nums, int val) {
        // это сохраняет порядок
        int n = nums.size();
        int i = 0; // текущий
        int j = 0; // впереди идущий
        while (j < n) {
            while (j < n && nums[j] == val)
                j++;
            if (j >= n)
                break;
            if (i != j) {
                nums[i++] = nums[j++];
                continue;
            }
            i++;
            j++;
        }
        return i;
    }

    int removeElement(vector<int>& nums, int val) {
        // порядок не сохраняется
        int n = nums.size();
        int i = 0; // текущий
        int j = n - 1; // впереди идущий
        while (i <= j) {
            if (nums[i] == val) {
                swap(nums[i], nums[j]);
                j--;
            } else {
                i++;
            }
        }
        return i;
    }
};

void test()
{
    vector<int> n1 {0,1,2,2,3,0,4,2};
    Solution s;
    int val = 2;
    int k = s.removeElement(n1, val);
    printV(n1);
    cout << k << endl;
}

#endif // C0027_H
