#ifndef HELPERS_H
#define HELPERS_H

#include <vector>
#include <iostream>
#include <cassert>

using namespace std;

template<typename T>
void printV(const vector<T> &r)
{
    cout << "[";
    for (size_t j = 0; j < r.size(); j++) {
        cout << r[j];
        if (j < r.size() - 1)
            cout << ",";
    }
    cout << "]" << endl;
}

#endif // HELPERS_H
