/*
121. Best Time to Buy and Sell Stock
Easy
26.6K
843
Companies
You are given an array prices where prices[i] is the price of a given stock on the ith day.

You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.

Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.



Example 1:

Input: prices = [7,1,5,3,6,4]
Output: 5
Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.
Example 2:

Input: prices = [7,6,4,3,1]
Output: 0
Explanation: In this case, no transactions are done and the max profit = 0.


Constraints:

1 <= prices.length <= 10^5
0 <= prices[i] <= 10^4
 */
#ifndef C0121_H
#define C0121_H

#include "global.h"

class Solution {
public:
    int maxProfit1(vector<int>& prices) {
        // правильно, но слишком медленно: смотрим текущую цену и максимальный элемент
        // в оставшейся части
        int maxp = 0;
        int maxel = INT32_MIN;
        for (auto it = prices.cbegin(); it != prices.cend(); ++it) {
            int curPrice = *it;
            auto maxit = std::max_element(it, prices.cend());
            if (maxit == prices.cend())
                break;
            if (maxp < *maxit - curPrice)
                maxp = *maxit - curPrice;
        }
        return maxp;
    }
    int maxProfit(vector<int>& prices) {
        // хитрожопые люди сокращают время работы не алгоритма,
        // а время чтения из stdin
        ios_base::sync_with_stdio(false);
        // суть в следующем: нам надо найти, во-первых, самую возможно низкую цену,
        // но при этом чтобы разница в ценах была наибольшей
        // таким образом мы найдём весь свинг, даже если там  будут провалы
        // если же обнаружится, что цена опустилась ниже, значит, надо передвинуться туда,
        // однако при этом dpmax может и не измениться, и остаться наибольшим,
        // итак, минимум постоянно передвигается, а разница перезаписывается
        // только если она превышает предыдущую
        int pmin = INT32_MAX;
        int dpmax = 0;
        for (int p : prices) {
            pmin = min(p, pmin);
            dpmax = max(dpmax, p - pmin);
        }
        return dpmax;
    }

};

void test()
{
    vector<int> prices = {7,1,5,3,6,4};
    Solution s;
    assert(5 == s.maxProfit(prices));
}

#endif // C0121_H
