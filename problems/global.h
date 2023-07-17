#ifndef GLOBAL_H
#define GLOBAL_H

#include <cassert>
#include <string>
#include <iostream>
#include <numeric>
#include <vector>
#include <algorithm>
#include <set>
#include <unordered_set>
#include <stack>
#include <cstring>
#include <map>

using namespace std;

template<typename T>
void printV2(const vector<vector<T>> &r)
{
    cout << "[";
    for (size_t i = 0; i < r.size(); i++) {
        cout << "[";
        for (size_t j = 0; j < r[i].size(); j++) {
            cout << r[i][j];
            if (j < r[i].size() - 1)
                cout << ",";
        }
        cout << "]";
        if (i < r.size() - 1)
            cout << ",";
    }
    cout << "]" << endl;
}

template<typename T>
void printV(const vector<T> &r, int iFrom = -1, int iTo = -1)
{
    cout << "[";
    size_t j = iFrom >= 0 ? iFrom : 0;
    size_t n = iTo >= 0 && iTo >= iFrom ? iTo : r.size();
    for (; j < n; j++) {
        cout << r[j];
        if (j < r.size() - 1)
            cout << ",";
    }
    cout << "]" << endl;
}

#endif // GLOBAL_H
