#ifndef P1_1_21_H
#define P1_1_21_H

#include "../helpers.h"

class Solution
{
public:
    static void test()
    {
        string name;
        int a, b;
        cout << "input name, a, b: ";
        cin >> name >> a >> b;
        double mid = (double)a / (double)b;
        cout << name << "\t" << a << "\t" << b << "\t"
             << setprecision(3) << mid << endl;
    }
};

#endif // P1_1_21_H
