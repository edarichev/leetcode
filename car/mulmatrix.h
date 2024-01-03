#ifndef MULMATRIX_H
#define MULMATRIX_H

#include <iostream>

void mulmatrix()
{
    const int m = 3, n = 2, k = 3;
    int aMatrix[m][n] = {{1, 4}, {2, 5}, {3, 6}};
    int bMatrix[n][k] = {{7, 8, 9}, {10, 11, 12}};
    int product[m][k] = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
    /* ==
47  52  57
64  71  78
81  90  99
*/
    for (int row = 0; row < m; row++) {
        for (int col = 0; col < k; col++) {
            for (int inner = 0; inner < n; inner++) {
                product[row][col] += aMatrix[row][inner] * bMatrix[inner][col];
            }
            std::cout << product[row][col] << "  ";
        }
        std::cout << "\n";
    }
}

#endif // MULMATRIX_H
