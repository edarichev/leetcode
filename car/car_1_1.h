#ifndef CAR_1_1_H
#define CAR_1_1_H

#include "macro.h"
#include <iostream>
#include <string>
#include <set>
#include <vector>
#include <bitset>


using namespace std;
/*
1.1. Все ли символы в строке встречаются только 1 раз?
*/
class CAR_1_1
{
public:
    // с множеством
    static bool isDistinct_withSet(const string &str)
    {
        std::set<char> chars;
        for (auto &&c : str) {
            if (chars.find(c) != chars.end())
                return false;
            chars.emplace(c);
        }
        return true;
    }

    static bool isDistinct_withBitSet(const string &str)
    {
        std::bitset<256> bs;
        for (auto &&c : str) {
            if (bs[c])
                return false;
            bs[c] = 1;
        }
        return true;
    }

    static bool isDistinct_withCycles(const string &str)
    {
        for (size_t i = 0; i < str.length() - 1; i++) {
            for (size_t j = i + 1; j < str.length(); j++) {
                if (str[i] == str[j])
                    return false;
            }
        }
        return true;
    }

    static void test()
    {
        string s1 = "hello";
        string s2 = "world";
        ASSERT(isDistinct_withSet(s1) == false);
        ASSERT(isDistinct_withSet(s2) == true);
        ASSERT(isDistinct_withBitSet(s1) == false);
        ASSERT(isDistinct_withBitSet(s2) == true);
        ASSERT(isDistinct_withCycles(s1) == false);
        ASSERT(isDistinct_withCycles(s2) == true);
    }
};

#endif // CAR_1_1_H
