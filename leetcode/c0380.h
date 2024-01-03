/*
380. Insert Delete GetRandom O(1)
Medium
7.7K
407
Companies
Implement the RandomizedSet class:

RandomizedSet() Initializes the RandomizedSet object.
bool insert(int val) Inserts an item val into the set if not present. Returns true if the item was not present, false otherwise.
bool remove(int val) Removes an item val from the set if present. Returns true if the item was present, false otherwise.
int getRandom() Returns a random element from the current set of elements (it's guaranteed that at least one element exists when this method is called). Each element must have the same probability of being returned.
You must implement the functions of the class such that each function works in average O(1) time complexity.



Example 1:

Input
["RandomizedSet", "insert", "remove", "insert", "getRandom", "remove", "insert", "getRandom"]
[[], [1], [2], [2], [], [1], [2], []]
Output
[null, true, false, true, 2, true, false, 2]

Explanation
RandomizedSet randomizedSet = new RandomizedSet();
randomizedSet.insert(1); // Inserts 1 to the set. Returns true as 1 was inserted successfully.
randomizedSet.remove(2); // Returns false as 2 does not exist in the set.
randomizedSet.insert(2); // Inserts 2 to the set, returns true. Set now contains [1,2].
randomizedSet.getRandom(); // getRandom() should return either 1 or 2 randomly.
randomizedSet.remove(1); // Removes 1 from the set, returns true. Set now contains [2].
randomizedSet.insert(2); // 2 was already in the set, so return false.
randomizedSet.getRandom(); // Since 2 is the only number in the set, getRandom() will always return 2.


Constraints:

-231 <= val <= 231 - 1
At most 2 * 105 calls will be made to insert, remove, and getRandom.
There will be at least one element in the data structure when getRandom is called.
 */
#ifndef C0380_H
#define C0380_H

#include "global.h"

#pragma GCC optimize("Ofast")
#pragma GCC target("avx,avx2,fma")

static const int _=[]{ios::sync_with_stdio(false);cin.tie(nullptr);cout.tie(nullptr);return 0;}();

class RandomizedSet {
    vector<int> _set;
public:
    RandomizedSet() {
        ios_base::sync_with_stdio(false);
        _set.reserve(200000);
    }

    bool insert(int val) {
        auto it = lower_bound(_set.begin(), _set.end(), val);
        if (it == _set.end() || (val < *it)) {
            _set.insert(it, val);
            return true;
        }
        return false;
    }

    bool remove(int val) {
        auto it = lower_bound(_set.begin(), _set.end(), val);
        if (it == _set.end() || *it != val)
            return false;
        _set.erase(it);
        return true;
    }

    int getRandom() {
        if (_set.empty())
            return 0;
        int r = _set.size() * rand() / RAND_MAX;
        return *(_set.begin() + r);
    }

    void clear()
    {
        _set.clear();
    }
};

/**
 * Your RandomizedSet object will be instantiated and called as such:
 * RandomizedSet* obj = new RandomizedSet();
 * bool param_1 = obj->insert(val);
 * bool param_2 = obj->remove(val);
 * int param_3 = obj->getRandom();
 */

void test()
{
    RandomizedSet *randomizedSet = new RandomizedSet();
    assert(1 == randomizedSet->insert(1)); // Inserts 1 to the set. Returns true as 1 was inserted successfully.
    assert(0 == randomizedSet->remove(2)); // Returns false as 2 does not exist in the set.
    assert(1 == randomizedSet->insert(2)); // Inserts 2 to the set, returns true. Set now contains [1,2].
    randomizedSet->getRandom(); // getRandom() should return either 1 or 2 randomly.
    assert(1 == randomizedSet->remove(1)); // Removes 1 from the set, returns true. Set now contains [2].
    assert(0 == randomizedSet->insert(2)); // 2 was already in the set, so return false.
    randomizedSet->getRandom(); // Since 2 is the only number in the set, getRandom() will always return 2.
    randomizedSet->clear();

    assert(1 == randomizedSet->insert(-1));
    assert(0 == randomizedSet->remove(-2));
    assert(1 == randomizedSet->insert(-2));
    randomizedSet->getRandom();
    assert(1 == randomizedSet->remove(-1));
    assert(0 == randomizedSet->insert(-2));
    randomizedSet->getRandom();
    delete randomizedSet;
}

#endif // C0380_H
