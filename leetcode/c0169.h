/*
169. Majority Element
Easy
15.6K
458
Companies
Given an array nums of size n, return the majority element.

The majority element is the element that appears more than ⌊n / 2⌋ times. You may assume that the majority element always exists in the array.



Example 1:

Input: nums = [3,2,3]
Output: 3
Example 2:

Input: nums = [2,2,1,1,1,2,2]
Output: 2


Constraints:

n == nums.length
1 <= n <= 5 * 104
-109 <= nums[i] <= 109


Follow-up: Could you solve the problem in linear time and in O(1) space?
 */
#ifndef C0169_H
#define C0169_H

#include "global.h"

class Solution {
public:
    int majorityElement1(vector<int>& nums) {
        int n = nums.size();
        if (n == 0)
            return -1;
        // допустим, что можно сортировать
        std::sort(nums.begin(), nums.end());
        int maxCountIndex = 0; // индекс
        int v = nums[0];
        int maxCount = 1;
        int curCount = 1;
        int curSecIndex = 0;
        for (int i = 1; i < n; i++) {
            if (nums[i] == v) {
                curCount++;
                continue;
            }
            if (maxCount < curCount) {
                maxCount = curCount;
                maxCountIndex = curSecIndex;
            }
            curSecIndex = i;
            curCount = 1;
            v = nums[i];
        }
        if (maxCount < curCount) {
            maxCount = curCount;
            maxCountIndex = curSecIndex;
        }
        return nums[maxCountIndex];
    }


    int majorityElement2(vector<int>& nums) {
        int n = nums.size();
        if (n == 0)
            return -1;
        // допустим, сортировать нельзя
        unordered_map<int, int> s;
        for (auto &&c : nums) {
            if (s.count(c) == 0)
                s[c] = 1;
            else
                s[c]++;
        }
        int vMax = -1;
        int cMax = 0;
        for (auto &&c : s) {
            if (c.second > vMax) {
                vMax = c.second;
                cMax = c.first;
            }
        }
        return cMax;
    }

    int majorityElement(vector<int>& nums) {
        int n = nums.size();
        if (n == 0)
            return -1;
        // будем увеличивать на 1, если число повторяется
        // если встретилось другое число, уменьшим на 1
        // если < 0, то берём новое число и считаем заново
        // суть в том, что при k>n/2 эта сумма всегда положительна
        // т.к. кол-во основных элементов больше, чем всех других
        int elem;
        int count = 0;

        for (int e : nums) {
            if (count == 0)
                elem = e;
            if (elem == e)
                count++;
            else
                count--;
        }
        return elem;
    }
};

void test()
{
    vector<int> v {5,6,6};
    Solution s;
    int k = s.majorityElement(v);
    assert(k == 6);
}

#endif // C0169_H
