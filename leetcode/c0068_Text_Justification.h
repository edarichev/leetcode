/*
68. Text Justification
Hard
2.4K
3.5K
Companies
Given an array of strings words and a width maxWidth, format the text such that each line has exactly maxWidth characters and is fully (left and right) justified.

You should pack your words in a greedy approach; that is, pack as many words as you can in each line. Pad extra spaces ' ' when necessary so that each line has exactly maxWidth characters.

Extra spaces between words should be distributed as evenly as possible. If the number of spaces on a line does not divide evenly between words, the empty slots on the left will be assigned more spaces than the slots on the right.

For the last line of text, it should be left-justified, and no extra space is inserted between words.

Note:

A word is defined as a character sequence consisting of non-space characters only.
Each word's length is guaranteed to be greater than 0 and not exceed maxWidth.
The input array words contains at least one word.


Example 1:

Input: words = ["This", "is", "an", "example", "of", "text", "justification."], maxWidth = 16
Output:
[
   "This    is    an",
   "example  of text",
   "justification.  "
]
Example 2:

Input: words = ["What","must","be","acknowledgment","shall","be"], maxWidth = 16
Output:
[
  "What   must   be",
  "acknowledgment  ",
  "shall be        "
]
Explanation: Note that the last line is "shall be    " instead of "shall     be", because the last line must be left-justified instead of fully-justified.
Note that the second line is also left-justified because it contains only one word.
Example 3:

Input: words = ["Science","is","what","we","understand","well","enough","to","explain","to","a","computer.","Art","is","everything","else","we","do"], maxWidth = 20
Output:
[
  "Science  is  what we",
  "understand      well",
  "enough to explain to",
  "a  computer.  Art is",
  "everything  else  we",
  "do                  "
]


Constraints:

1 <= words.length <= 300
1 <= words[i].length <= 20
words[i] consists of only English letters and symbols.
1 <= maxWidth <= 100
words[i].length <= maxWidth
 */
#ifndef C0068_TEXT_JUSTIFICATION_H
#define C0068_TEXT_JUSTIFICATION_H

#include "global.h"

static int _ = [](){ ios_base::sync_with_stdio(false); return 0;}();

class Solution {
public:
    string pad(vector<string>& words, int iFrom, int iTo, int maxWidth, bool last = false)
    {
        vector<string> words2(words.begin() + iFrom, words.begin() + iTo);
        if (words2.size() == 1)
            return words2.back() + string(maxWidth - words2.back().length(), ' ');
        string ret;
        ret.reserve(maxWidth);
        if (last) {
            for (size_t i = 0; i < words2.size() - 1; i++) {
                ret.append(words2[i]).push_back(' ');
            }
            ret.append(words2.back());
            ret.append(maxWidth - ret.length(), ' ');
            return ret;
        }
        int len = 0;
        for (auto &s : words2)
            len += s.length();
        while (len < maxWidth) {
            for (size_t i = 0; i < words2.size() - 1; i++) {
                words2[i].push_back(' ');
                len++;
                if (len == maxWidth)
                    break;
            }
        }
        for (auto &s : words2)
            ret.append(s);
        return ret;
    }
    vector<string> fullJustify(vector<string>& words, int maxWidth) {
        vector<string> v; // примерно выделить достаточно памяти
        v.reserve(words.size() / 2);
        // перебираем слова и смотрим, не превышает ли их общая длина
        // maxWidth, включая хотя бы 1 пробел между ними.
        // если превышет, то формируем строку из непревышающих
        // переходим к следующей строке
        size_t j = 0; // начальный индекс - первое слово в новом предложении
        size_t k = 0; // (exclusive) конечный индекс - последнее слово в новом предложении
        int lineLen = 0;
        for (size_t i = 0; i < words.size(); i++) {
            int len = words[i].length();
            lineLen += len;
            if (lineLen == maxWidth) {
                // по 1 пробелу между словами
                lineLen = 0;
                k = i + 1;
                v.push_back(pad(words, j, k, maxWidth));
                j = k;
                continue;
            } else if (lineLen > maxWidth) {
                // вставить пробелы
                lineLen = 0;
                k = i;
                v.push_back(pad(words, j, k, maxWidth));
                i--;
                j = k;
                continue;
            }
            lineLen++;// пробел
        }
        if (j < words.size())
            v.push_back(pad(words, j, words.size(), maxWidth, true));
        return v;
    }
};

void test()
{
    Solution s;
    vector<string> words = {"This", "is", "an", "example", "of", "text", "justification."};
    int maxWidth = 16;
    /*printV(s.fullJustify(words, maxWidth));
    words = {"What","must","be","acknowledgment","shall","be"}, maxWidth = 16;
    printV(s.fullJustify(words, maxWidth));
    words = {"Science","is","what","we","understand","well","enough","to","explain","to","a","computer.","Art","is","everything","else","we","do"}, maxWidth = 20;
    printV(s.fullJustify(words, maxWidth));*/
    words = {"ask","not","what","your","country","can","do","for","you","ask","what","you","can","do","for","your","country"}, maxWidth = 16;
    vector<string> expected = {"ask   not   what","your country can","do  for  you ask","what  you can do","for your country"};
    maxWidth = 16;
    //printV(s.fullJustify(words, maxWidth));
    assert(expected == s.fullJustify(words, maxWidth));
}

#endif // C0068_TEXT_JUSTIFICATION_H
