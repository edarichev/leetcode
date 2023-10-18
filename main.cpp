#include <iostream>
// #include "leetcode/c0015_3Sum.h"
#include "cpptemplates/variadic1.h"

using namespace std;

int main()
{
    //test(); // leetcode
    int x = vt::foldAdd(1, 2, 3, 4, 5);
    int y = vt::foldMul(1, 2, 3, 4, 5);
    cout << x << " " << y << endl;
    vt::printWithCout(1, 2, 3, "Hello");
    return 0;
}
