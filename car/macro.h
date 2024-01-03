#ifndef MACRO_H
#define MACRO_H

#define NAME(x) #x
#include <iostream>
#include <vector>

#define ASSERT(cond) if (!(cond)) { \
    std::cout << "Error: line=" << __LINE__ << ",  file=" << __FILE__ << \
    std::endl; }

void printArray(int *a, int rows, int cols);

template<typename T>
void print(const std::vector<T> &v)
{
    for (auto &&i : v)
        std::cout << i << " ";
    std::cout << "\n";
}

bool equals(int *a, int *b, int M, int N);

#endif // MACRO_H
