#ifndef FACTORIAL_H
#define FACTORIAL_H

template <int N>
struct Factorial
{
    enum { value = N * Factorial<N - 1>::value };
};

template <>
struct Factorial<0>
{
    enum { value = 1 };
};

#endif // FACTORIAL_H
