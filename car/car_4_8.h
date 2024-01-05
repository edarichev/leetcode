#ifndef CAR_4_8_H
#define CAR_4_8_H

#include "car/bnode.h"
#include "car/macro.h"
#include <set>
class CAR_4_8
{
public:

    static BNode *findParent(BNode *n1, BNode *n2)
    {
        std::set<BNode*> nodes1;
        // сначала все предки первого узла
        while (n1) {
            n1 = n1->parent;
            nodes1.insert(n1);
        }
        // теперь проходим по второму
        while (n2) {
            n2 = n2->parent;
            if (nodes1.find(n2) != nodes1.end())
                return n2;
        }
        return nullptr;
    }

    static void test()
    {
        BNode *topValid = new BNode(8);
        auto f4 = topValid->addLeft(4);
        auto f2 = f4->addLeft(2);
        auto f6 = f4->addRight(6);
        auto f10 = topValid->addRight(10);
        auto f11 = f10->addLeft(11);
        auto f20 = f10->addRight(20);

        ASSERT(findParent(f20, f6) == topValid);
        delete topValid;
    }
};

#endif // CAR_4_8_H
