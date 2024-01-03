#ifndef PERMUTE_H
#define PERMUTE_H

#include <iostream>

using namespace std;

void perm(string &str, int i, int n)
{
    if (i == n) {
        for (auto &&c : str) {
            cout << c << " ";
        }
        cout << endl;
    } else {
        for (int j = i; j < n; j++) {
            char c;
            c = str[i];
            str[i] = str[j];
            str[j] = c;
            perm(str, i + 1, n);
            c = str[i];
            str[i] = str[j];
            str[j] = c;
        }
    }
}

#endif // PERMUTE_H
