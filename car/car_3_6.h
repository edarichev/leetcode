#ifndef CAR_3_6_H
#define CAR_3_6_H

#include "macro.h"
#include "list"

// решение: если разрешено использовать только один список
class CAR_3_6
{
public:
    // если добавятся ёжики, мыши... то придётся вводиь на каждого по списку
    enum class AnimalType
    {
        Dog,
        Cat,
    };

    template<typename T = AnimalType>
    struct AnimalTypeName
    {
        static std::string name(T t)
        {
            if (t == AnimalType::Cat) return "Cat";
            if (t == AnimalType::Dog) return "Dog";
            return "Unknown";
        }
    };

    class Animal
    {
    public:
        AnimalType type;
        int id;
        Animal(int i, AnimalType t) : type(t), id(i) {}
        void print()
        {
            std::cout << "id=" << id << " type=" << (int)type
                      << "(" << AnimalTypeName<>::name(type) << ")\n";
        }
    };

    class AnimalQueue
    {
        std::list<Animal> q;
    public:
        bool empty()
        {
            return q.empty();
        }

        void enqueue(int id, AnimalType t)
        {
            enqueue(Animal(id, t));
        }

        void enqueue(Animal &&a)
        {
            q.emplace_front(std::move(a));
        }

        Animal dequeueAny()
        {
            auto p = q.back();
            q.pop_back();
            return p;
        }

        Animal dequeueAnimal(AnimalType t)
        {
            auto it = q.end();
            while (it != q.begin()) {
                --it;
                if ((*it).type == t) {
                    auto a = (*it);
                    q.erase(it);
                    return a;
                }
            }
            throw std::domain_error("No animals with specified type");
        }

        Animal dequeueDog()
        {
            return dequeueAnimal(AnimalType::Dog);
        }

        Animal dequeueCat()
        {
            return dequeueAnimal(AnimalType::Cat);
        }

        void print()
        {
            for (auto &&i : q) {
                std::cout << "id=" << i.id << " type=" << (int)i.type
                          << "(" << AnimalTypeName<>::name(i.type) << ")\n";
            }
        }
    };

    static void test()
    {
        AnimalQueue q;
        q.enqueue(1, AnimalType::Cat);
        q.enqueue(2, AnimalType::Cat);
        q.enqueue(3, AnimalType::Dog);
        q.enqueue(4, AnimalType::Cat);
        q.enqueue(5, AnimalType::Dog);
        //q.print();
        //auto d1 = q.dequeueDog();
        //d1.print();
    }
};

#endif // CAR_3_6_H
















