#ifndef CAR_1_8_H
#define CAR_1_8_H

#include "macro.h"
#include <set>

class CAR_1_8
{
public:

    template <size_t M, size_t N>
    static void zeroWithSets(int (&a)[M][N])
    {
        std::set<int> rows;
        std::set<int> columns;
        for (size_t i = 0; i < M; i++) {
            for (size_t j = 0; j < N; j++) {
                if (a[i][j] == 0) {
                    if (rows.find(i) == rows.end()) {
                        rows.insert(i);
                    }
                    if (columns.find(j) == columns.end()) {
                        columns.insert(j);
                    }
                }
            }
        }

        for (auto &&r : rows) {
            for (size_t j = 0; j < N; j++)
                a[r][j] = 0;
        }
        for (auto &&c : columns) {
            for (size_t j = 0; j < M; j++)
                a[j][c] = 0;
        }
    }

    static void test()
    {
        const int M = 4;
        const int N = 4;
        int img1[M][N]  = { {1,  0,   3,  4},
                            {5,  6,   7,  8},
                            {9,  10, 0, 12},
                            {13, 14, 15, 16} };
        int test[M][N]  = { {0,  0,   0,  0},
                            {5,  0,   0,  8},
                            {0,  0,   0,  0},
                            {13, 0,   0, 16} };
        zeroWithSets<M, N>(img1);
        //printArray(img1[0], M, N);
        ASSERT(equals(img1[0], test[0], M, N));
    }
};

#endif // CAR_1_8_H
