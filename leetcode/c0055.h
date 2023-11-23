/*
55. Jump Game
Medium
16.7K
889
Companies
You are given an integer array nums. You are initially positioned at the array's first index, and each element in the array represents your maximum jump length at that position.

Return true if you can reach the last index, or false otherwise.



Example 1:

Input: nums = [2,3,1,1,4]
Output: true
Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
Example 2:

Input: nums = [3,2,1,0,4]
Output: false
Explanation: You will always arrive at index 3 no matter what. Its maximum jump length is 0, which makes it impossible to reach the last index.


Constraints:

1 <= nums.length <= 104
0 <= nums[i] <= 105
*/
#ifndef C0055_H
#define C0055_H

#include "global.h"

static int _ = [](){ios_base::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr);return 0;}();

class Solution {
public:
    bool canJump(vector<int>& nums) {
        // иными словами, если задан шаг N, то мы можем переместиться от 1 до N,
        // а не на N.
        // пример:
        //       3 2 1 0 4
        // i=0:  ^ - - -    // шаг 3
        //       ^ - -      // шаг 2
        //       ^ -        // шаг 1
        // i=1:    ^ - -    // шаг 2
        //         ^ -      // шаг 1
        // i=2:      ^ -    // шаг 1
        // i=3:        ^    // стоп, вернуть false
        // на каждом шаге определяем следующий индекс, на который мы можем
        // максимально переместиться.
        // двигаемся, пока этот следующий индекс превышает или равен текущему индексу i.
        // если следующий отстал от текущего, значит, на нём прыжки остановятся,
        // и достичь конца не можем.
        // перемещение на 1 равносильно минимальному шагу в 1.
        // т.е. рекурсивно мы решали бы так: сдвинулись на N, от него ещё на M и до конца,
        // если не вышли - снова начинаем, но от N-1 и т.д. Так можно, но очень долго
        // и много жрёт.
        // но все эти шаги по сути сводятся к вычислению максимального прыжка от каждого
        // элемента, т.к. если мы делаем проход от некоего элемента n+2, это значит, что при предыдущем
        // максимальном шаге 3 мы ничего не нашли и принялись считать для шага 2,
        // который как раз и попадает на n+2.
        int n = nums.size();
        int next = 0;
        for (int i = 0; i < n; i++) {
            if (i > next)
                return false;
            next = max(next, i + nums[i]);
        }
        return true;
    }
};

void test()
{
    vector<int> nums = {2,3,1,1,4};
    Solution s;
    assert(true == s.canJump(nums));
    nums = {3,2,1,0,4};
    assert(false == s.canJump(nums));
    nums = {2,3,1,1,4};
    assert(true == s.canJump(nums));
    nums = {2,5,0,0};
    assert(true == s.canJump(nums));
    nums = {2,0,0};
    assert(true == s.canJump(nums));
}

#endif // C0055_H
