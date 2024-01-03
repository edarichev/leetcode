#ifndef CAR_1_6_H
#define CAR_1_6_H

#include "macro.h"

class CAR_1_6
{
public:
    static std::string compress(const std::string &str)
    {
        std::string s;
        int i = 0;
        char cprev = 0;
        for (auto &&c : str) {
            if (cprev && c != cprev) {
                s += cprev;
                s += '0' + i;
                i = 0;
            }
            i++;
            cprev = c;
        }
        if (cprev && i > 0) {
            s += cprev;
            s += '0' + i;
        }
        if (s.length() < str.length())
            return s;
        return str;
    }

    static void test()
    {
        std::string s1 = "aabcccccaaa";
        std::cout << compress(s1) << std::endl;
        ASSERT(compress(s1) == "a2b1c5a3");
        ASSERT(compress("abc") == "abc");
    }
};
#endif // CAR_1_6_H
