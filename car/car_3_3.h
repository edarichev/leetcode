#ifndef CAR_3_3_H
#define CAR_3_3_H

#include "macro.h"
#include "vector"
#include "stack"

class CAR_3_3
{
public:

    template<typename T>
    class SetOfStacks
    {
        size_t limit = 3; // не больше стольки в каждом стеке
        std::vector<std::stack<T>> _stacks;
    public:
        void push(T v)
        {
            if (_stacks.size() == 0 || _stacks.back().size() == limit) {
                _stacks.push_back(std::stack<T>());
            }
            _stacks.back().push(v);
        }

        T &top()
        {
            if (_stacks.empty())
                throw;
            return _stacks.back().top();
        }

        void pop()
        {
            if (_stacks.empty())
                throw;
            _stacks.back().pop();
            if (_stacks.back().size() == 0)
                _stacks.pop_back();
        }

        void print1Stack(std::stack<T> &st)
        {
            if (st.empty())
                return;
            std::stack<T> tmp;
            while (!st.empty()) {
                std::cout << st.top() << " ";
                tmp.push(st.top());
                st.pop();
            }
            std::cout << "\n";
            while (!tmp.empty()) {
                st.push(tmp.top());
                tmp.pop();
            }
        }

        void print()
        {
            for (size_t i = 0; i < _stacks.size(); i++){
                auto &c = _stacks[i];
                std::cout << i++ << ":\t";
                print1Stack(c);
            }
        }
    };

    static void test()
    {
        SetOfStacks<int> s1;
        s1.push(1);
        s1.push(2);
        s1.push(3);
        s1.push(4);
        s1.push(5);
        ASSERT(s1.top() == 5);
        s1.pop();
        ASSERT(s1.top() == 4);
        s1.pop();
        ASSERT(s1.top() == 3);
        s1.pop();
        ASSERT(s1.top() == 2);
        s1.pop();
        ASSERT(s1.top() == 1);
    }
};
#endif // CAR_3_3_H
