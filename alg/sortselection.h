#ifndef SORTSELECTION_H
#define SORTSELECTION_H

#include "../helpers.h"
#include <cassert>
#include <vector>

// сортировка выбором
void sort_selection(std::vector<int> &a)
{
    for (size_t i = 0; i < a.size() - 1; i++) {
        size_t minj = i;
        for (size_t j = i + 1; j < a.size(); j++) {
            if (a[j] < a[minj])
                minj = j;
        }
        std::swap(a[i], a[minj]);
    }
}

void test_sort_selection()
{
    std::vector<int> a1 {4,7,3,1,8,9,1,3,2,8};
    std::vector<int> a2 {1,1,2,3,3,4,7,8,8,9};
    sort_selection(a1);
    //printV(a1);
    assert(a1 == a2);
}

#endif // SORTSELECTION_H
