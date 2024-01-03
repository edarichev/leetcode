#ifndef TEST_MT1_H
#define TEST_MT1_H

// multi-threading test 1

#include <future>
#include <random>
#include <chrono>
#include <thread>
#include <iostream>

int doWork(int x)
{
    std::default_random_engine dre(x);
    std::uniform_int_distribution<int> id(10, 1000);

    for (int i = 0; i < 10; i++) {
        std::this_thread::sleep_for(std::chrono::microseconds(id(dre)));
        std::cout.put(x).flush();
    }
    return x;
}

int func1()
{
    return doWork('+');
}

int func2()
{
    return doWork('.');
}

void runmt1()
{
    std::launch lp = std::launch::async;
    std::future<int> f1(std::async(lp, func1));
    int result2 = func2();
    int c = f1.get() + result2;
    std::cout << c << std::endl;
}

#endif // TEST_MT1_H
