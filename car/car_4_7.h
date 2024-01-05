#ifndef CAR_4_7_H
#define CAR_4_7_H

#include "helpers.h"
#include "macro.h"
#include "bnode.h"
#include <algorithm>

using namespace std;

class CAR_4_7
{
public:

    static std::vector<char> getOrder(const std::vector<char> &projects,
                                      const std::vector<std::pair<char, char>> &depend)
    {
        // это не дерево, а, скорее, граф, т.к. проекты много раз могут зависеть
        // один от другого, поэтому лучше поместить всё в вектор, чтобы наиболее
        // независимые находились в его начале
        std::vector<char> v;
        // вставить зависимости
        for (auto &&d : depend) {
            // сначала ищем независимый
            auto f = std::find(v.begin(), v.end(), d.second);
            auto insDependend = v.end(); // куда вставить зависимый
            if (f == v.end()) { // если нет, то вставляем
                // он всегда будет ближе к началу
                v.insert(v.begin(), d.second);
                insDependend = std::next(v.begin());
            }
            // теперь ищем зависимый
            f = std::find(v.begin(), v.end(), d.first);
            if (f == v.end()) // если его нет, то вставим после независимого
                v.insert(insDependend, d.first);
        }
        // добавить независимые
        for (auto &&p : projects) {
            if (std::find(v.begin(), v.end(), p) == v.end())
                v.insert(v.begin(), p);
        }
        return v;
    }

    static void test()
    {
        std::vector<char> projects {'a', 'b', 'c', 'd', 'e', 'f'};
        std::vector<std::pair<char, char>> depend;
        depend.push_back({'d', 'a'});
        depend.push_back({'b', 'f'});
        depend.push_back({'d', 'b'});
        depend.push_back({'a', 'f'});
        depend.push_back({'c', 'd'});

        std::vector<char> order = getOrder(projects, depend);
        // проект 'e' может быть построен когда угодно,
        // поэтому порядок может быть разным
        // например: feabdc, efabdc, fabdce и т.п.
        // важно в таком порядке: fabcd
        printV(order);
    }
};

#endif // CAR_4_7_H
