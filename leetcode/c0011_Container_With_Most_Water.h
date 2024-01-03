/*
11. Container With Most Water
Medium
25.3K
1.4K
Companies
You are given an integer array height of length n. There are n vertical lines drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).

Find two lines that together with the x-axis form a container, such that the container contains the most water.

Return the maximum amount of water a container can store.

Notice that you may not slant the container.



Example 1:


Input: height = [1,8,6,2,5,4,8,3,7]
Output: 49
Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.
Example 2:

Input: height = [1,1]
Output: 1


Constraints:

n == height.length
2 <= n <= 105
0 <= height[i] <= 104
 */
#ifndef C0011_CONTAINER_WITH_MOST_WATER_H
#define C0011_CONTAINER_WITH_MOST_WATER_H

#include "global.h"

static int _ = [](){ios_base::sync_with_stdio(false); return 0;}();

class Solution {
public:
    int maxArea(vector<int>& height) {
        int a = 0;//наибольшая площадь
        int left = 0;
        int right = height.size() - 1;
        while (left < right) {
            //  площадь между left__right:
            int s = (right - left) * min(height[left], height[right]);
            // выбрать наибольшую
            a = max(a, s);
            // высота стенок должна быть не меньше, чем в предыдущих итерациях
            // внутренние объёмы могут расти только за счёт высоты стенок
            // если повезёт, стенки будут достаточно высокие, чтобы превысить
            // объём, вычисленный за счёт ширины.
            if (height[left] < height[right]) {
                left++;
            } else {
                right--;
            }
        }
        return a;
    }
};

void test()
{
    vector<int> height = {1,8,6,2,5,4,8,3,7};
    Solution s;
    cout << s.maxArea(height);
}

#endif // C0011_CONTAINER_WITH_MOST_WATER_H
