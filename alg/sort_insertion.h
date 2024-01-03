#ifndef SORT_INSERTION_H
#define SORT_INSERTION_H

#include "../helpers.h"
#include <cassert>
#include <vector>

// сортировка вставками
void sort_insertion(std::vector<int> &a)
{
    for (size_t i = 0; i < a.size(); i++) {
        for (size_t j = i; j > 0 && (a[j] < a[j - 1]); j--) {
            std::swap(a[j], a[j - 1]);
        }
    }
}

void test_sort_insertion()
{
    std::vector<int> a1 {4,7,3,1,8,9,1,3,2,8};
    std::vector<int> a2 {1,1,2,3,3,4,7,8,8,9};
    sort_insertion(a1);
    //printV(a1);
    assert(a1 == a2);
}

#endif // SORT_INSERTION_H
