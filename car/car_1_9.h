#ifndef CAR_1_9_H
#define CAR_1_9_H

#include "macro.h"

class CAR_1_9
{
public:

    static bool isSubstring(const std::string &sWhere, const std::string &sWhat)
    {
        return sWhere.find(sWhat) != std::string::npos;
    }

    static bool isCycle(const std::string &s1, const std::string &s2)
    {
        if (s1.length() != s2.length())
            return false;
        std::string s = s1 + s1;
        return isSubstring(s, s2);
    }

    static void test()
    {
        std::string s1 = "waterbottle";
        std::string s2 = "erbottlewat";
        std::string s3 = "exbottlewat";
        ASSERT(isCycle(s1, s2) == true);
        ASSERT(isCycle(s1, s3) == false);
    }
};

#endif // CAR_1_9_H
