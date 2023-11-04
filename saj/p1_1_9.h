#ifndef P1_1_9_H
#define P1_1_9_H

#include <string>
#include <iostream>
#include <algorithm>

using namespace std;

class Solution
{
public:
    static std::string toBinaryString(int n)
    {
        // решение через добавление значения последнего бита
        // с последующим разворотом строки

        if (!n)
            return "0";
        std::string s;
        while (n) {
            int i = n % 2;
            s.push_back('0' + i);
            n /= 2;
        }
        std::reverse(s.begin(), s.end());
        return s;
    }
    static std::string toBinaryString2(int n)
    {
        if (!n)
            return "0";
        std::string s;
        while (n) {
            s.push_back('0' + (n & 0x1));
            n >>= 1;
        }
        std::reverse(s.begin(), s.end());
        return s;
    }

    static std::string toBinaryString3(uint32_t n)
    {
        // с учётом полной ширины типа и без разворота строки
        // здесь учитываем беззнаковость или
        // применяем другую маску, т.к. бит 31 всегда 1 или 0
        if (!n)
            return "0";
        std::string s;
        s.reserve(sizeof (uint32_t) * 8);
        while (n) {
            s.push_back('0' + ((n & 0x8000'0000) >> 31));
            n <<= 1;
        }
        return s;
    }
    static void test()
    {
        cout << toBinaryString(0b10010011) << endl;
        cout << toBinaryString2(0b10010011) << endl;
        cout << toBinaryString3(0b10010011) << endl;
    }
};

#endif // P1_1_9_H
