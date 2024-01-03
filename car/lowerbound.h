#ifndef LOWERBOUND_H
#define LOWERBOUND_H

#include "macro.h"
/* Задача: В упорядоченном векторе методом бинарного поиска найти указанный элемент,
 * если есть одинаковые, вернуть самый левый из них.
 */

class LowerBound
{
public:

    static int bin2(const std::vector<int> &arr, int x)
    {
        int left = 0;
        int right = arr.size() - 1;
        while (left <= right)
        {
            int mid = left + (right - left) / 2;
            if (arr[mid] == x)
            {
                if (mid > 0 && arr[mid - 1] == x)
                    right = mid - 1;
                else
                    return mid;
            }
            else if (arr[mid] < x)
            {
                left = mid + 1;
            }
            else
            {
                right = mid - 1;
            }
        }
        return -1;
    }

    static int findElement(const std::vector<int> &v, int x)
    {
        if (!v.size())
            return -1;
        return bin2(v, x);
    }

    static void test()
    {
        std::vector<int> v{3,3,3,4,5,6,6,6,7,8,9,10,10};
        int pos = findElement(v, 10);
        std::cout << pos << "\n";
        //ASSERT(pos == 0);
    }
};

#endif // LOWERBOUND_H
