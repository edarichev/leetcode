#ifndef TEMPLATES_H
#define TEMPLATES_H

template<typename T>
T summ(const T &v)
{
    return v;
}

template <typename T, typename ...Trest>
T summ(const T &v1, Trest ...args)
{
    return v1 + summ(args...);
}

template <int n>
struct Fact
{
    static const int f = Fact<n-1>::f * n;
};

template <>
struct Fact<1>
{
    static const int f = 1;
};

// usage:
//cout << summ(1, 2, 3, 4, 5) << endl;
//cout << Fact<5>::f << endl;

void Display()
{

}

template<typename T, typename ...Rest>
void Display(T v, Rest...args)
{
    //cout << v << endl;
    Display(args...);
}

// Display(1, 4.5, "hello");


#endif // TEMPLATES_H
