#ifndef CAR_2_5_H
#define CAR_2_5_H

#include "macro.h"
#include "list1.h"

// это разновидность длинной арифметики
class CAR_2_5
{
public:
    // от меньшего
    template<class T> typename std::enable_if_t<std::is_integral_v<T>, void>
    static addFromLittle(List1<T> &a, List1<T> &b, List1<T> &result)
    {
        result.clear();
        T cf = 0; // перенос
        auto pa = a.head;
        auto pb = b.head;
        while (pa && pb) {
            T va = pa->value;
            T vb = pb->value;
            T sum = va + vb + cf;
            cf = sum / 10;
            sum %= 10;
            result.add(sum);
            pa = pa->next;
            pb = pb->next;
        }
        auto p = pa == nullptr ? pb : pa;
        while (p) {
            T v = p->value;
            T sum = v + cf;
            v = sum % 10;
            cf = sum / 10;
            result.add(v);
            p = p->next;
        }
        if (cf)
            result.add(cf);
    }

    // когда больший спереди
    template<class T> typename std::enable_if_t<std::is_integral_v<T>, void>
    static addFromBig(List1<T> &a, List1<T> &b, List1<T> &result)
    {
        a.revert();
        b.revert();
        addFromLittle(a, b, result);
        result.revert();
    }

    static void test()
    {
        List1<int> list1;
        List1<int> list2;
        List1<int> listResult;
        List1<double> list3;
        list3.add(4.5);//non-int->error

        list1.add({7, 1, 6});
        list2.add({5, 9, 2});
        addFromLittle(list1, list2, listResult);
        ASSERT(listResult.equals({2, 1, 9}));
/*        list1.println();
        std::cout << " + ";
        list2.println();
        std::cout << " = ";
        listResult.println();
        std::cout << "\n";
*/
        list1.clear();
        list2.clear();
        list1.add({6, 1, 7});
        list2.add({2, 9, 5});
        addFromBig(list1, list2, listResult);
        ASSERT(listResult.equals({9, 1, 2}));

    }
};

#endif // CAR_2_5_H
