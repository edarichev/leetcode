#ifndef CAR_1_7_H
#define CAR_1_7_H

#include "macro.h"

class CAR_1_7
{
public:
    static const int N = 4;


    static void rotateRight(int (&a)[N][N])
    {
        for (int row = 0; row < N / 2; row++) {
            for (int col = row; col < N - row - 1; col++) {
                int tmp = a[row][col];
                a[row][col] = a[N - 1 - col][row];
                a[N - 1 - col][row] = a[N - 1 - row][N - 1 - col];
                a[N - 1 - row][N - 1 - col] = a[col][N - 1 - row];
                a[col][N - 1 - row] = tmp;
            }
        }
    }

    static bool equals(int (&img1)[N][N], int (&img2)[N][N])
    {
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                if (img1[i][j] != img2[i][j])
                    return false;
            }
        }
        return true;
    }

    static void print(int (&img1)[N][N])
    {
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                std::cout << img1[i][j] << "\t";
            }
            std::cout << "\n";
        }
    }

    static void test()
    {
        int img1[N][N]  = { {1,  2,   3,  4},
                            {5,  6,   7,  8},
                            {9,  10, 11, 12},
                            {13, 14, 15, 16} };

        int test1[N][N] = { {13, 9,   5,  1},
                            {14, 10,  6,  2},
                            {15, 11,  7,  3},
                            {16, 12,  8,  4}};
        rotateRight(img1);
        print(img1);
        ASSERT(equals(img1, test1) == true);
    }
};
#endif // CAR_1_7_H
