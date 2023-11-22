/*
88. Merge Sorted Array
Easy
11.3K
1.1K
Companies
You are given two integer arrays nums1 and nums2, sorted in non-decreasing order, and two integers m and n, representing the number of elements in nums1 and nums2 respectively.

Merge nums1 and nums2 into a single array sorted in non-decreasing order.

The final sorted array should not be returned by the function, but instead be stored inside the array nums1. To accommodate this, nums1 has a length of m + n, where the first m elements denote the elements that should be merged, and the last n elements are set to 0 and should be ignored. nums2 has a length of n.



Example 1:

Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
Output: [1,2,2,3,5,6]
Explanation: The arrays we are merging are [1,2,3] and [2,5,6].
The result of the merge is [1,2,2,3,5,6] with the underlined elements coming from nums1.
Example 2:

Input: nums1 = [1], m = 1, nums2 = [], n = 0
Output: [1]
Explanation: The arrays we are merging are [1] and [].
The result of the merge is [1].
Example 3:

Input: nums1 = [0], m = 0, nums2 = [1], n = 1
Output: [1]
Explanation: The arrays we are merging are [] and [1].
The result of the merge is [1].
Note that because m = 0, there are no elements in nums1. The 0 is only there to ensure the merge result can fit in nums1.


Constraints:

nums1.length == m + n
nums2.length == n
0 <= m, n <= 200
1 <= m + n <= 200
-109 <= nums1[i], nums2[j] <= 109


Follow up: Can you come up with an algorithm that runs in O(m + n) time?
 */

#ifndef C0088_H
#define C0088_H

#include "global.h"

static int _ = [](){ios_base::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr);return 0;}();

class Solution {
public:
    void merge1(vector<int>& nums1, int m, vector<int>& nums2, int /*n*/) {
        // это правильно, быстро и просто, но это мухлёж, O((m+n)log(m+n))
        std::copy(nums2.begin(), nums2.end(), nums1.begin() + m);
        std::sort(nums1.begin(), nums1.end());
    }

    void merge2(vector<int>& nums1, int m, vector<int>& nums2, int n) {
        // копирование с начала с копией массива
        if (m == 0) {
            std::copy(nums2.begin(), nums2.end(), nums1.begin());
            return;
        }
        if (n == 0)
            return;
        int i = 0, j = 0, k = 0;
        // делаем копию, чтобы не перемещать
        vector<int> x(m + n);
        for (k = 0; k < (m + n); k++) {
            if (i == m) {
                x[k] = nums2[j++];
                continue;
            }
            if (j == n) {
                x[k] = nums1[i++];
                continue;
            }
            if (nums1[i] < nums2[j]) {
                x[k] = nums1[i++];
            } else {
                x[k] = nums2[j++];
            }
        }
        std::copy(x.begin(), x.end(), nums1.begin());
    }

    void merge(vector<int>& nums1, int m, vector<int>& nums2, int n) {
        // копирование с конца, работаем в том же массиве num1
        if (m == 0) {
            std::copy(nums2.begin(), nums2.end(), nums1.begin());
            return;
        }
        if (n == 0)
            return;
        int i = n - 1;
        int j = m - 1;
        int k = m + n - 1;
        for (; k >= 0; k--) {
            if (i < 0) {
                nums1[k] = nums1[j--];
                continue;
            }
            if (j < 0) {
                nums1[k] = nums2[i--];
                continue;
            }
            if (nums1[j] > nums2[i]) {
                nums1[k] = nums1[j];
                j--;
                continue;
            }
            nums1[k] = nums2[i--];
        }
    }
};

void test()
{
    vector<int> nums1  {1,2,3,0,0};
    int m = 3;
    vector<int> nums2 {};
    int n = 0;
    Solution s;
    s.merge(nums1, m, nums2, n);
    printV(nums1);
}

#endif // C0088_H
