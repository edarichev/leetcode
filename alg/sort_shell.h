#ifndef SORT_SHELL_H
#define SORT_SHELL_H

#include "../helpers.h"
#include <cassert>
#include <vector>

// сортировка Шелла
void sort_shell(std::vector<int> &a)
{
    size_t N = a.size();
    size_t h = 1;
    while (h < N / 3)
        h = h * 3 + 1;
    while (h >= 1) {
        for (size_t i = h; i < N; i++) {
            for (size_t j = i; j >= h && (a[j] < a[j - h]); j -= h)
                std::swap(a[j], a[j - h]);
        }
        h /= 3;
    }
}

void test_sort_shell()
{
    std::vector<int> a1 {4,7,3,1,8,9,1,3,2,8};
    std::vector<int> a2 {1,1,2,3,3,4,7,8,8,9};
    sort_shell(a1);
    printV(a1);
    assert(a1 == a2);
}

#endif // SORT_SHELL_H
