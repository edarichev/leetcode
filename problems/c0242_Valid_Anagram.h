/*
242. Valid Anagram
Easy
9.8K
312
Companies
Given two strings s and t, return true if t is an anagram of s, and false otherwise.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.



Example 1:

Input: s = "anagram", t = "nagaram"
Output: true
Example 2:

Input: s = "rat", t = "car"
Output: false


Constraints:

1 <= s.length, t.length <= 5 * 104
s and t consist of lowercase English letters.


Follow up: What if the inputs contain Unicode characters? How would you adapt your solution to such a case?
 */
#ifndef _242_Valid_Anagram_
#define _242_Valid_Anagram_

#include "global.h"

static int _ = [](){ ios_base::sync_with_stdio(false); return 0;}();

class Solution {
public:
    bool isAnagram(const string &s, const string &t) {
        // Анагра́мма (от греч. ανα- «пере» + γράμμα «буква») — литературный
        // приём, состоящий в перестановке букв или звуков определённого слова
        // (или словосочетания), что в результате даёт другое слово или словосочетание.
        // Silent->Listen
        // т.е. это перестановки в одном слове
        // в данном случае проще взять два массива из 26 элементов (lowercase letters),
        // где хранить кол-во, а сдвиг - это код буквы минус код 'a'б однако
        // для Unicode дешевле будет хэш-таблица, чем массив на 2^32 всех вохможных
        // символов.
        // Здесь: unordered_map быстрее в 2 раза, чем map
        unordered_map<char, int> m1; // буква-кол-во в первом слове
        unordered_map<char, int> m2; // буква-кол-во во втором слове
        // должно совпадать кол-во букв и сами буквы
        for (auto c : s) {
            auto it = m1.find(c);
            if (it == m1.end())
                m1[c] = 1;
            else
                (*it).second++;
        }
        for (auto c : t) {
            auto it = m2.find(c);
            if (it == m2.end())
                m2[c] = 1;
            else
                (*it).second++;
        }
        if (m1.size() != m2.size())
            return false;
        for (auto it = m1.begin(); it != m1.end(); ++it) {
            auto it2 = m2.find((*it).first);
            if (it2 == m2.end() || (*it2).second != (*it).second)
                return false;
        }
        return true;
    }
};

void test()
{
    string s = "anagram", t = "nagaram";
    assert(Solution().isAnagram(s, t) == true);
    s = "rat", t = "car";
    assert(Solution().isAnagram(s, t) == false);
    s ="aa"; t = "a";
    assert(Solution().isAnagram(s, t) == false);
}

#endif // _242_Valid_Anagram_
