#ifndef HELPERS_H
#define HELPERS_H

#include <list>
#include <vector>
#include <iostream>
#include <cassert>
#include <iomanip>
#include <chrono>

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
