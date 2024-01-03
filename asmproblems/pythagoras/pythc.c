#include <math.h>

int main(int argc, char *argv[])
{
    double a = 3;
    double b = 4;
    long n = 10000000000;
    while (n > 0) {
        sqrt(a*a + b*b);
        n--;
    }
    return 0;
}
