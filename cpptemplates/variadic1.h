#ifndef VARIADIC1_H
#define VARIADIC1_H

#include <iostream>

namespace vt {

///////////////// Вывод переменного числа аргументов ///////////////////

void printvt()
{
    // завершение рекурсии
}

template<typename T, typename ...TArgs>
void printvt(T arg1, TArgs... args)
{
    using std::cout;
    cout << arg1;
    printvt(args...);
}


///////////// Выражения свёртки ////////////

// (... op pack)
template<typename... T>
auto foldAdd(T... args)
{
    return (... + args);
}

// (pack op ...)
template<typename... T>
auto foldMul(T... args)
{
    return (args * ...);
}

// (init op ... op pack)
template<typename... TArgs>
void printWithCout(TArgs const&... args)
{
    (std::cout << ... << args) << '\n';
}

// (pack op ... op init)


} // namespace vt

#endif // VARIADIC1_H
