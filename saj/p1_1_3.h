#ifndef P1_1_3_H
#define P1_1_3_H

#include "../helpers.h"

class Solution
{
public:
    static void readNumbers()
    {
        int a, b, c;
        cin >> a >> b >> c;
        cout << ((a == b) == c) << endl;
    }
};

#endif // P1_1_3_H
