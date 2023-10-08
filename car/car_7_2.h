#ifndef CAR_7_2_H
#define CAR_7_2_H

#include "macro.h"
#include <thread>
#include <queue>
#include <chrono>
#include <list>

namespace car_7_2 {

enum class EmployeeType
{
    Operator,
    Manager,
    Director
};

class Employee
{
protected:
    int id {};
    EmployeeType _type;
public:
    Employee(int i) {id = i;}
    virtual ~Employee(){}
    virtual std::string toString() const = 0;
    EmployeeType type() const { return _type;}
};

class Operator : public Employee
{
public:
    Operator(int i) : Employee(i)
    {
        _type = EmployeeType::Operator;
    };

    virtual std::string toString() const
    {
        return "Operator #" + std::to_string(id);
    }
};

class Manager : public Employee
{
public:
    Manager(int i) : Employee(i)
    {
        _type = EmployeeType::Manager;
    }

    virtual std::string toString() const
    {
        return "Manager #" + std::to_string(id);
    }
};

class Director : public Employee
{
public:
    Director(int i) : Employee(i)
    {
        _type = EmployeeType::Director;
    }

    virtual std::string toString() const
    {
        return "Director #" + std::to_string(id);
    }
};

// звонок
class Call
{
    const int MAX_DURATION = 3000;//millisec
    int duration;
    int _id{};
    std::chrono::time_point<std::chrono::system_clock> _start;
    std::chrono::time_point<std::chrono::system_clock> _end;
public:
    Call(int i) : _id(i)
    {
        duration = MAX_DURATION * (rand() / (RAND_MAX + 1.));
        _start = std::chrono::system_clock::now();
        _end = _start + std::chrono::milliseconds(duration);
    }

    int id() const { return _id; }

    bool expired()
    {
        auto t = std::chrono::system_clock::now();
        return _end < t;
    }
};

class CallHandler
{
    // "база" сотрудников
    std::vector<Operator> _empOperators;
    std::vector<Manager> _empManagers;
    std::vector<Director> _empDirectors;

    // рабочие места - если очередь опустела, переходим к вышестояящим
    std::queue<Employee*> _operators;
    std::queue<Employee*> _managers;
    std::queue<Employee*> _directors;

    // занятые (очереди звонков)
    // используем список, чтобы моделировать разную продолжительность звонков
    // и извлекать те, что устарели
    std::list<std::pair<Call, Employee*>> _calls;
    int OperatorsCount = 10;
    int ManagerCount = 5;
    int DirectorsCount = 2;
public:
    CallHandler()
    {
        // заполняем базу
        for (int i = 0; i < OperatorsCount; i++)
            _empOperators.emplace_back(Operator(i));
        for (int i = 0; i < ManagerCount; i++)
            _empManagers.emplace_back(Manager(i));
        for (int i = 0; i < DirectorsCount; i++)
            _empDirectors.emplace_back(Director(i));
        // сажаем на рабочие места
        for (int i = 0; i < OperatorsCount; i++)
            _operators.push(&_empOperators[i]);
        for (int i = 0; i < ManagerCount; i++)
            _managers.push(&_empManagers[i]);
        for (int i = 0; i < DirectorsCount; i++)
            _directors.push(&_empDirectors[i]);
    }

    void dispatchCall(Call &&call)
    {
        freeEmployees();
        if (handleCall(call, _operators))
            return;
        if (handleCall(call, _managers))
            return;
        if (handleCall(call, _directors))
            return;
        std::cerr << "Call #" << call.id() << " rejected.\n";
    }

    bool handleCall(Call call, std::queue<Employee*> &q)
    {
        if (q.empty())
            return false;
        // есть свободные операторы
        auto emp = q.front();
        q.pop();
        std::cerr << "Call #" << call.id() << " received by " << emp->toString() << std::endl;
        _calls.emplace_back(std::pair(call, emp));
        return true;
    }

    void freeEmployees()
    {
        auto it = _calls.begin();
        while (it != _calls.end()) {
            auto &c = *it;
            if (c.first.expired()) {
                auto *p = c.second;
                std::cerr << p->toString() << " is free.\n";
                moveBack(p);
                it = _calls.erase(it);
                continue;
            }
            ++it;
        }
    }

    void moveBack(Employee *e)
    {
        switch (e->type()) {
        case EmployeeType::Operator: _operators.push(e); break;
        case EmployeeType::Manager: _managers.push(e); break;
        case EmployeeType::Director: _directors.push(e); break;
        }
    }
};


} // namespace car_7_2

class CAR_7_2
{
public:
    static void test()
    {
        using namespace car_7_2;
        CallHandler callHandler;
        typedef std::chrono::milliseconds ms;
        int nCalls = 30; // число звонков
        for (int i = 0; i < nCalls; i++) {
            callHandler.dispatchCall(Call(i));

            std::this_thread::sleep_for(ms(200));
        }
        // эмулируем завершение всех вызовов
        for (int i = 0; i < nCalls; i++) {
            callHandler.freeEmployees();
            std::this_thread::sleep_for(ms(200));
        }
    }
};

#endif // CAR_7_2_H
