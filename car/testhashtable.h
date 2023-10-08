#ifndef TESTHASHTABLE_H
#define TESTHASHTABLE_H

#include <iostream>
#include <vector>
#include <optional>

using namespace std;

uint64_t hashCode(const std::string &str) {
    uint64_t A = 54059;
    uint64_t B = 76963;
    uint64_t C = 37;
    unsigned h = C;
    for (size_t i = 0; i < str.length(); i++) {
        h = (h * A) ^ (str[i] * B);
    }
    return h;
}

class HTNode
{
public:
    std::string key;
    std::string value;
    HTNode(){}
    HTNode(const string &k, const string &v)
    {
        key = k;
        value = v;
    }
};

class HashTable
{
    int M = 7;
    std::vector<std::vector<HTNode>> valuesList;
public:
    HashTable()
    {
        valuesList.resize(M);
    }

    size_t index(const std::string &key)
    {
        return hashCode(key) % M;
    }

    void add(const std::string &key, const std::string &value)
    {
        uint64_t h = index(key);
        auto &v = valuesList[h];
        for (auto &&item : v) {
            if (item.key == key) {
                item.value = value;
                return;
            }
        }
        // изменить размер, если слишком много
        if (valuesList[h].size() * 1.0 / M > 0.3) {
            M *= 2;
            auto newList(std::move(valuesList));
            valuesList.resize(M);
            for (auto &&i : newList) {
                for (auto &&c : i) {
                    add(c.key, c.value);
                }
            }
            h = index(key);
        }
        valuesList[h].emplace_back(HTNode{key, value});
    }

    void remove(const std::string &key)
    {
        uint64_t h = index(key);
        auto &v = valuesList[h];
        for (auto it = v.begin(); it != v.end(); ++it) {
            if ((*it).key == key) {
                v.erase(it);
                return;
            }
        }
    }

    std::optional<std::string> get(const std::string &key)
    {
        uint64_t h = index(key);
        auto &v = valuesList[h];
        size_t n = v.size();
        if (n == 1 && v.front().key == key)
            return v.front().value;
        for (size_t i = 0; i < v.size(); i++) {
            if (v[i].key == key)
                return v[i].value;
        }
        return std::optional<std::string>();
    }

    void print()
    {
        for (size_t i = 0; i < valuesList.size(); i++) {
            cout << i << "\t";
            for (auto &&item : valuesList[i]) {
                cout << "[" << item.value << "] ";
            }
            cout << endl;
        }
    }
};

void test_hashTable()
{
    for (int i = 0; i < 1000; i++) {
        auto s = string("key") + to_string(i);
        //cout << s << " = " << hashCode(s) % 7 << endl;
    }
    //cout << hashCode("key0") % 7 << endl;
    //cout << hashCode("key2") % 7 << endl;
    HashTable t;
    std::string key1 = "key1";
    std::string value1 = "value1";
    //t.add(key1, value1);
    t.add("key0", "0");
    t.add("key2", "2");
    t.add("key6", "6");
    t.add("key3", "3");
    t.add("key8", "8");
    t.add("key9", "9");
    t.add("key10", "10");
    t.print();
    cout << "t[" << "key8" <<"] = " << t.get("key8").value() << endl;
    //t.remove("key8");
    //cout << "t[" << "key8" <<"] = " << t.get("key8").has_value() << endl;

}

#endif // TESTHASHTABLE_H
