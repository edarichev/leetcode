#ifndef CAR_4_1_H
#define CAR_4_1_H

#include "macro.h"
#include "graph.h"
#include <algorithm>

class CAR_4_1
{
    static std::vector<int> _visited;
    static bool isVisited(int id)
    {
        return std::find(_visited.begin(), _visited.end(), id) != _visited.end();
    }
public:

    static bool search(const Graph<int> &g, int idFrom, int idTo, std::vector<int> &outRoute)
    {
        // здесь явно нужный id проверен и существует
        _visited.emplace_back(idFrom);
        if (idFrom == idTo) {
            return true;
        }
        for (auto &&i : g.links) {
            if (i.first == idFrom) {
                for (auto &&link : i.second) {
                    if (isVisited(link))
                        continue;
                    if (search(g, link, idTo, outRoute)) {
                        outRoute.insert(outRoute.begin(), link);
                        return true;
                    }
                }
            }
        }
        return false;
    }

    static void getRoute(const Graph<int> &g,
                         int idFrom,
                         int idTo,
                         std::vector<int> &outRoute)
    {
        outRoute.clear();
        _visited.clear();
        for (auto &&n : g.nodes) {
            if (n.id == idFrom) {
                if (search(g, idFrom, idTo, outRoute))
                    outRoute.insert(outRoute.begin(), idFrom);
                break;
            }
        }
        _visited.clear();
    }

    static void test()
    {
        // см. orgraph1.png
        Graph<int> g1;
        g1.addLink(1, {8});
        g1.addLink(8, {2});
        g1.addLink(2, {7});
        g1.addLink(7, {4, 3});
        g1.addLink(4, {1});
        g1.addLink(3, {5});
        g1.addLink(3, {6});
        std::vector<int> r;
        getRoute(g1, 1, 6, r);
        ASSERT(r.size() == 6);
        getRoute(g1, 3, 1, r);
        ASSERT(r.size() == 0);
    }
};

std::vector<int> CAR_4_1::_visited;

#endif // CAR_4_1_H
