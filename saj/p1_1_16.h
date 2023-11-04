#ifndef P1_1_16_H
#define P1_1_16_H

#include <iostream>
#include <string>
using namespace std;

class Solution
{
public:
    static std::string exR1(int n)
    {
        if (n <= 0)
            return "";
        return exR1(n-3) + std::to_string(n) + exR1(n-1) + std::to_string(n);
    }
    static void test()
    {
        cout << exR1(6) << endl;
    }
};

#endif // P1_1_16_H
