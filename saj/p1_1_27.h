#ifndef P1_1_27_H
#define P1_1_27_H

/*
0.246094
calls: 1233000000
4675.89ms
0.246094
0.0001ms
 */

#pragma GCC optimize ("O3")

#include "helpers.h"

class Solution
{
public:
    inline static int nCalls = 0;
    static double binomial1(int N, int k, double p)
    {
        if (N == 0 && k == 0) return 1.0;
        if (N < 0 || k < 0) return 0;
        //здесь: double q = 1.0 - p;
        nCalls++;
        return (1.0 - p) * binomial1(N - 1, k, p) +
                p * binomial1(N - 1, k - 1, p);
    }

    static double binomial2(int N, int k, double p)
    {
        if (N == 0 && k == 0) return 1.0;
        if (N < 0 || k < 0) return 0;
        // Pn(k)=n!/(k!(n-k)!)*p^k*q^(n-k)
        // коэффициент в числителе можно сократить на k!
        double kb = 1;
        unsigned long long nkfact = 1;
        int i = N - k + 1; // k == 0...N
        int j = 1;
        while (i <= N) {
            kb *= i;
            i++;
            nkfact *= j;
            j++;
        }
        kb /= nkfact;
        i = 0;
        while (i < k) {
            kb *= p;
            i++;
        }
        i = 0;
        double q = 1.0 - p;
        while (i < (N - k)) {
            kb *= q;
            i++;
        }
        return kb;
    }

    static void test()
    {
        int n = 1000000;
        using std::chrono::high_resolution_clock;
        using std::chrono::duration_cast;
        using std::chrono::duration;
        using std::chrono::milliseconds;

        int N = 10, k = 5;
        double p = 0.5;
        const double test_b1 = 0.246094;
        const double e       = 0.00001;
        nCalls = 0;
        double b1;
        int i = 0;
        auto t1 = high_resolution_clock::now();
        while (i++ < n)
            b1 = binomial1(N, k, p);
        auto t2 = high_resolution_clock::now();
        duration<double, std::milli> ms_double = t2 - t1;
        cout << b1 << endl;
        cout << "calls: " << nCalls << endl;
        cout << ms_double.count() << "ms" << endl; // 4675.89ms
        assert(abs(b1 - test_b1) <= e);
        i = 0;
        t1 = high_resolution_clock::now();
        while (i++ < n)
            b1 = binomial2(N, k, p);
        t2 = high_resolution_clock::now();
        ms_double = t2 - t1;

        cout << b1 << endl;
        cout << ms_double.count() << "ms" << endl; // 0.0001ms
        assert(abs(b1 - test_b1) <= e);
    }
};

#endif // P1_1_27_H
