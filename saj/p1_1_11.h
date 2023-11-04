#ifndef P1_1_11_H
#define P1_1_11_H

#include <iostream>
using namespace std;

class Solution
{
public:
    static void print2dArray(const bool *arr, int rows, int columns)
    {
        cout << "  ";
        for (int c = 0; c < columns; c++) {
            cout << c;
        }
        cout << endl;
        const bool *p = arr;
        for (int r = 0; r < rows; r++) {
            cout << r << " ";
            for (int c = 0; c < columns; c++) {
                bool v = *p++;
                if (v)
                    cout << "*";
                else
                    cout << " ";
            }
            cout << endl;
        }
    }
    static void test()
    {
        const int rows = 2;
        const int columns = 3;
        bool a[rows][columns] = {
            {true, true, false},
            {false, false, true}
        };
        print2dArray(a[0], rows, columns);
    }
};
#endif // P1_1_11_H
