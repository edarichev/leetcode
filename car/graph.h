#ifndef GRAPH_H
#define GRAPH_H

#include <vector>
#include <string>
#include <iostream>

template <typename TIdentifier, typename TValue = int>
class GraphNode
{
public:
    TIdentifier id;
    TValue value;
    GraphNode(const TIdentifier &i) {id = i;}
};

template <typename TIdentifier>
class Graph
{
public:
    using GNode = GraphNode<TIdentifier>;
    using LinkRecord = std::pair<TIdentifier, std::vector<TIdentifier>>;
    // узлы ханим отдельно, т.к. связи могут отсутствовать
    std::vector<GNode> nodes;
    // список смежности
    std::vector<LinkRecord> links;

    void addLink(const TIdentifier &id, const std::initializer_list<TIdentifier> &lst)
    {
        nodes.emplace_back(GNode(id));
        links.emplace_back(std::make_pair(id, lst));
    }

    void printRoute(const std::vector<TIdentifier> &route)
    {
        for (auto &&c : route)
            std::cout << c << "->";
        std::cout << "\n";
    }
};

void test_graph()
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
}

#endif // GRAPH_H
