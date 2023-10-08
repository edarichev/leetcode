#ifndef SMALLS_H
#define SMALLS_H

#include "algorithm"
#include <exception>
#include <string>
#include <vector>
#include <iostream>
#include <cassert>

using namespace std;


int gcd(int p, int q)
{
    if (q == 0)
        return p;
    return gcd(q, p % q);
}

double newtonsqrt(double n)
{
    if (n == 0)
        return std::numeric_limits<double>::infinity();
    double e = 1.0E-15;
    double x = 1;
    while (std::abs(x * x  - n) > e) {
        x = (x + n / x) / 2.0;
    }
    return x;
}

int lg(int n)
{
    int lg2n = -1;
    while (n) {
        n >>= 1;
        lg2n++;
    }
    return lg2n;
}

// пример функтора - сортировка с режимом
/**
 * @brief The Cmp struct
 *
 * @code
    vector<string> v {"hello", "world", "to", "all" };

    Cmp c(Cmp::Mode::Less);

    sort(v.begin(), v.end(), c);
    printV(v);

    c._mode = Cmp::Mode::Greater;
    sort(v.begin(), v.end(), c);
    printV(v);
 * @endcode
 */
struct Cmp
{
    enum class Mode
    {
        Less,
        Greater
    };

    Cmp(Mode m) : _mode(m) {}

    Mode _mode = Mode::Less;
private:

    bool compare(const string &v1, const string &v2)
    {
        switch (_mode) {
        case Mode::Greater: return v2 < v1;
        case Mode::Less: return v1 < v2;
        default:
            throw ("invalid sorting mode");
        }
    }

public:

    bool operator()(const string &v1, const string &v2)
    {
        return compare(v1, v2);
    }
};

void exampleBind()
{
    using namespace std::placeholders;
    vector<string> v {"hello", "world", "to", "all" };

    auto m = [](const string &s) { return s == "to"; };
    auto f = std::bind(m, _1);
    auto it = find_if(v.begin(), v.end(), f);
    if (it != v.end())
        cout << *it;
}

#include <stack>
class DijkstraCalc
{
    stack<char> operations;
    stack<double> values;
public:
    // полностью скобочные выражения
    // cout << DijkstraCalc().eval("(5+(6*4))");
    double eval(const string &str)
    {
        // только целые числа без точек
        size_t i = 0, n = str.length();
        string token;
        while (i < n) {
            char c = str[i];
            switch (c) {
            case '(':
                break;
            case '+':
            case '-':
            case '*':
            case '/':
                operations.push(c);
                break;
            case ')': {
                char op = operations.top();
                operations.pop();
                double op1, op2;
                switch (op) {
                case '+':
                case '-':
                case '*':
                case '/':
                    op1 = values.top(); values.pop();
                    op2 = values.top(); values.pop();
                    break;
                default:
                    throw domain_error("Unsupported operation");
                }
                switch (op) {
                case '+':op1 += op2;break;
                case '-':op1 -= op2;break;
                case '*':op1 *= op2;break;
                case '/':op1 /= op2;break;
                }
                values.push(op1);
                break;
            }
            default:
                if (isdigit(c)) {
                    token = "";
                    while (i < n) {
                        c = str[i];
                        if (!isdigit(c))
                            break;
                        token.push_back(c);
                        i++;
                    }
                    double v = stod(token);
                    values.push(v);
                    continue;
                }
                throw domain_error("Unexpected character");
            }
            i++;
        }
        double x = values.top();
        values.pop();
        assert(values.empty());
        assert(operations.empty());
        return x;
    }
};

/**
 *    Queue<int> q;
    q.push(1);
    q.push(2);
    q.push(3);
    cout << q.pop() << " "  << q.pop() << " " << q.pop();
 */
template <typename T>
class Queue
{
    struct Node{
        T value {};
        Node *next = nullptr ;
        Node *prev = nullptr ;
        Node(T t) : value(t) {}
    };

    Node *top = nullptr ;
public:
    ~Queue()
    {
        Node *p = top;
        while (p) {
            Node *n = p->next;
            delete p;
            p = n;
        }
    }
    void push(T t)
    {
        Node *n = new Node(t);
        if (top)
            top->prev = n;
        n->next = top;
        top = n;
    }

    T pop()
    {
        Node *p = top;
        while (p) {
            if (p->next == nullptr) {
                T v = p->value;
                if (p->prev) {
                    p->prev->next = nullptr;
                } else {
                    top = nullptr;
                }
                delete p;
                return v;
            } else
                p = p->next;
        }
        throw domain_error("queue is empty");
    }
};

#endif // SMALLS_H
