/*
1768. Merge Strings Alternately
Easy
2.4K
44
Companies
You are given two strings word1 and word2. Merge the strings by adding letters in alternating order, starting with word1. If a string is longer than the other, append the additional letters onto the end of the merged string.

Return the merged string.



Example 1:

Input: word1 = "abc", word2 = "pqr"
Output: "apbqcr"
Explanation: The merged string will be merged as so:
word1:  a   b   c
word2:    p   q   r
merged: a p b q c r
Example 2:

Input: word1 = "ab", word2 = "pqrs"
Output: "apbqrs"
Explanation: Notice that as word2 is longer, "rs" is appended to the end.
word1:  a   b
word2:    p   q   r   s
merged: a p b q   r   s
Example 3:

Input: word1 = "abcd", word2 = "pq"
Output: "apbqcd"
Explanation: Notice that as word1 is longer, "cd" is appended to the end.
word1:  a   b   c   d
word2:    p   q
merged: a p b q c   d


Constraints:

1 <= word1.length, word2.length <= 100
word1 and word2 consist of lowercase English letters.
 */
#ifndef C1768_H
#define C1768_H

#include <cassert>
#include <string>
#include <iostream>

using namespace std;

class Solution {
public:
    string mergeAlternately(string word1, string word2) {
        string result;
        size_t len = min(word1.length(), word2.length());
        size_t i = 0;
        for (i = 0; i < len; i++) {
            result += word1[i];
            result += word2[i];
        }
        if (i < word1.length())
            result += word1.substr(i);
        if (i < word2.length())
            result += word2.substr(i);
        return result;
    }
};

void test()
{
    string word1 = "abc", word2 = "pqr";
    Solution s;
    assert("apbqcr" == s.mergeAlternately(word1, word2));
}

#endif // C1768_H
