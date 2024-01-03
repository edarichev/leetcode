#ifndef P1_1_33_MATRIX_H
#define P1_1_33_MATRIX_H

#include "helpers.h"
#include <numeric>

class Matrix
{
public:
    template<typename T,
             typename = std::enable_if<std::is_integral_v<T>>,
             typename = std::enable_if<std::is_floating_point_v<T>>>
    static T dot(const std::vector<T> &x, const std::vector<T> &y)
    {
        assert(x.size() == y.size());
        // так:
        // return std::inner_product(x.begin(), x.end(), y.begin(), 0.0);
        // или так:
        double v = 0;
        for (auto ix = x.begin(), iy = y.begin(); ix != x.end(); ++ix, ++iy) {
            v += *ix * *iy;
        }
        return v;
    }

    template<typename T, int L, int M, int N,
             typename = std::enable_if<std::is_integral_v<T>>,
             typename = std::enable_if<std::is_floating_point_v<T>>>
    constexpr static void mul(const T (&xa)[L][M], const T (&xb)[M][N], T (&xc)[L][N])
    {
        for (int i = 0; i < L; i++) {
            for (int j = 0; j < N; j++) {
                T cij = 0;
                for (int r = 0; r < M; r++) {
                    cij += xa[i][r] * xb[r][j];
                }
                xc[i][j] = cij;
            }
        }
    }

    template<typename T, int M, int N,
             typename = std::enable_if<std::is_integral_v<T>>,
             typename = std::enable_if<std::is_floating_point_v<T>>>
    constexpr static void transpose(const T (&xa)[M][N], /*out*/ T (&xb)[N][M])
    {
        for (int i = 0; i < M; i++) {
            for (int j = 0; j < N; j++)
                xb[j][i] = xa[i][j];
        }
    }

    template<typename T, int Rows, int Cols>
    static void print(const T (&a)[Rows][Cols])
    {
        for (int i = 0; i < Rows; i++) {
            for (int j = 0; j < Cols; j++) {
                cout << setw(6) << a[i][j];
            }
            cout << endl;
        }
    }
};

class Solution
{
public:
    static void test()
    {
        vector<int> x {1, 2, 3};
        vector<int> y {4, 5, 6};
        auto scalarp = Matrix::dot(x, y);
        cout << scalarp << endl;
        assert(32 == scalarp);

        const int L = 5, M = 4, N = 5;
        int xa[L][M]{{1,2,3,4}, {5,6,7,8}, {9,10,11,12}, {13,14,15,16}, {17,18,19,20}};
        int xb[M][N]{{1,2,3,4,5},{6,7,8,9,10},{11,12,13,14,15},{16,17,18,19,20}};
        int xc[L][N]{};

        Matrix::mul(xa, xb, xc);
        Matrix::print(xc);

        int xta[M][N] {{1,2,3,4,5}, {6,7,8,9,10}, {11,12,13,14,15}, {16,17,18,19,20}};
        int xtb[N][M] {};
        Matrix::transpose(xta, xtb);
        Matrix::print(xtb);
    }
};

#endif // P1_1_33_MATRIX_H
