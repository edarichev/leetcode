#include "macro.h"

void printArray(int *a, int rows, int cols)
{
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            std::cout << a[i * rows + j] << "\t";
        }
        std::cout << "\n";
    }
}

bool equals(int *a, int *b, int M, int N)
{
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (a[i * M + j] != b[i * M +j])
                return false;
        }
    }
    return true;
}
