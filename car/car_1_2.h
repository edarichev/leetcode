#ifndef CAR_1_2_H
#define CAR_1_2_H

#include "macro.h"
#include <string>
#include <vector>
using namespace std;

/*
1.2. Для двух строк напишите метод, определяющий, является ли одна строка
перестановкой другой
 */
class CAR_1_2
{
public:
    static bool isStrPermutate(string &str, size_t i, size_t n, const string &strTest)
    {
        if (i == n) {
            return str == strTest;
        }
        for (size_t j = i; j < n; j++) {
            auto c = str[i];
            str[i] = str[j];
            str[j] = c;
            if (isStrPermutate(str, i + 1, n, strTest))
                return true;
            c = str[i];
            str[i] = str[j];
            str[j] = c;
        }
        return false;
    }
    static bool isPerm(const string &str1, const string &str2)
    {
        if (str1.length() != str2.length() || str1.length() == 0)
            return false;
        string st = str2;
        return isStrPermutate(st, 0, st.length(), str1);
    }
    static void test()
    {
        string s1 = "hello";
        string s2 = "world";
        string s3 = "olleh";
        ASSERT(isPerm(s1, s2) == false);
        ASSERT(isPerm(s1, s3) == true);
        ASSERT(isPerm(s2, s3) == false);
    }
};

#endif // CAR_1_2_H
