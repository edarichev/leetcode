/*
58. Length of Last Word
Easy
3.5K
186
Companies
Given a string s consisting of words and spaces, return the length of the last word in the string.

A word is a maximal
substring
 consisting of non-space characters only.



Example 1:

Input: s = "Hello World"
Output: 5
Explanation: The last word is "World" with length 5.
Example 2:

Input: s = "   fly me   to   the moon  "
Output: 4
Explanation: The last word is "moon" with length 4.
Example 3:

Input: s = "luffy is still joyboy"
Output: 6
Explanation: The last word is "joyboy" with length 6.


Constraints:

1 <= s.length <= 10^4
s consists of only English letters and spaces ' '.
There will be at least one word in s.
 */
#ifndef C0058_H
#define C0058_H

#include "global.h"

class Solution {
public:
    int lengthOfLastWord(const string &s) {
        // замена на const-ссылку ускоряет
        // непонятно, почему алгоритм с просмотром с 0 до n быстрее,
        // чем обратный.
        // по идее, мы же большую часть строки не смотрим
        ios_base::sync_with_stdio(false);
        int end = -1;
        int i = s.length() - 1;
        for (; i >= 0; i--) {
            if (s[i] != ' ')
                break;
        }
        if (i < 0)
            return 0;
        end = i;
        for (; i >= 0; i--) {
            if (s[i] == ' ')
                break;
        }
        return end - i;
    }
};

void test()
{
    string s = "   fly me   to   the moon  ";
    Solution sl;
    cout << sl.lengthOfLastWord(s) << endl;
}

#endif // C0058_H
