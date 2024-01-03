#ifndef P1_1_13_H
#define P1_1_13_H

#include <iostream>
using namespace std;

class Solution
{
public:
    static void test()
    {
        const int M = 2; //rows
        const int N = 3; //cols
        int a1[M][N] = {
            {1, 2, 3},
            {4, 5, 6}
        };

        int a2[N][M]{};

        for (int r = 0; r < M; r++) {
            for (int c = 0; c < N; c++) {
                a2[c][r] = a1[r][c];
            }
        }

        for (int r = 0; r < N; r++) {
            for (int c = 0; c < M; c++)
                cout << a2[r][c] << " ";
            cout << endl;
        }
    }
};

#endif // P1_1_13_H
