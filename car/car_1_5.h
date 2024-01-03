#ifndef CAR_1_5_H
#define CAR_1_5_H

#include "macro.h"
#include <string>
#include <vector>
#include <algorithm>

/*
Существуют три вида модифицирующих операций со строками: вставка
символа, удаление символа и замена символа. Напишите функцию, которая
проверяет, находятся ли две строки на расстоянии одной модификации (или
нуля модификаций).
 */
class CAR_1_5
{
public:
    // вообще, вряд ли на собеседовании будет требоваться это сделать,
    // скорее всего, тупо поперебирать с комбинациями,
    // но тем не менее, это будет покруче
    // Расстояние Левенштейна (редакционное расстояние, дистанция редактирования)
    // — метрика, измеряющая по модулю разность между двумя последовательностями
    // символов. Она определяется как минимальное количество односимвольных операций
    // (а именно вставки, удаления, замены), необходимых для превращения одной
    // последовательности символов в другую.
    static int levensteinDist(const std::string &s1, const std::string &s2)
    {
        size_t M = s1.length();
        size_t N = s2.length();
        std::vector<std::vector<int>> d;
        for (size_t i = 0; i <= M; i++)
            d.push_back(std::vector<int>(N + 1));

        // Алгоритм Вагнера — Фишера
        for (size_t i = 0; i <= M; i++)
            d[i][0] = i;
        for (size_t i = 0; i <= N; i++)
            d[0][i] = i;
        for (size_t i = 1; i <= M; i++) {
            for (size_t j = 1; j <= N; j++) {
                int del = d[i - 1][j] + 1; // элемент сверху
                int ins = d[i][j - 1] + 1; // элемент слева
                int sub = d[i - 1][j - 1] + (s1[i - 1] == s2[j - 1] ? 0 : 1); // по диагонали слева, сверху
                d[i][j] = std::min(del, std::min(ins, sub));
            }
        }
        return d[M][N];
    }

    static void test()
    {
        std::string sPale = "pale";
        std::string sPle = "ple";
        //std::cout << levensteinDist("connect", "conehead") << std::endl; // 4
        ASSERT(levensteinDist("Hello", "Hallo") == 1);
        ASSERT(levensteinDist("pale", "pale") == 0);
        ASSERT(levensteinDist("pale", "ple") == 1);
        ASSERT(levensteinDist("pales", "pale") == 1);
        ASSERT(levensteinDist("pale", "bale") == 1);
        ASSERT(levensteinDist("pale", "bake") != 1);
    }
};

#endif // CAR_1_5_H
