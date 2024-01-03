/* Также: №227
224. Basic Calculator
Hard
5.5K
410
Companies
Given a string s representing a valid expression, implement a basic calculator to evaluate it, and return the result of the evaluation.

Note: You are not allowed to use any built-in function which evaluates strings as mathematical expressions, such as eval().



Example 1:

Input: s = "1 + 1"
Output: 2
Example 2:

Input: s = " 2-1 + 2 "
Output: 3
Example 3:

Input: s = "(1+(4+5+2)-3)+(6+8)"
Output: 23


Constraints:

1 <= s.length <= 3 * 105
s consists of digits, '+', '-', '(', ')', and ' '.
s represents a valid expression.
'+' is not used as a unary operation (i.e., "+1" and "+(2 + 3)" is invalid).
'-' could be used as a unary operation (i.e., "-1" and "-(2 + 3)" is valid).
There will be no two consecutive operators in the input.
Every number and running calculation will fit in a signed 32-bit integer.
*/

#ifndef CALC_H
#define CALC_H

#include "global.h"

/**
 * @brief В-общем, это настоящий компилятор для стековой машины.
 * Можно сделать в разы быстрее, но этот расширяемый до любых выражений.
 */
class Solution
{
    enum class Token {
        Plus,
        Minus,
        Multiply,
        Divide,
        LeftParenth,
        RightParenth,
        Number,
        Eof,
    };

    enum class NodeType
    {
        None,
        BinaryOp,
        UnaryOp,
        LeftParenth,
        RightParenth,
        Number,
    };

    enum class OperationType
    {
        None, Add, Sub, Mul, Div, UMinus, UPlus
    };

    struct Node
    {
        NodeType nodeType = NodeType::None; // node type
        OperationType opType = OperationType::None; // operation
        int value = 0;// optional
    };

    stack<Node> machine;
    stack<Node> back; // т.к. несколько операций подряд может быть
    long val = 0;
    const char *p = nullptr;
    Token current;
    long result = 0;
public:

    // лексический анализ
    Token next()
    {
        val = 0;
        while (*p) {
            char c = *p;
            switch (c) {
            case ' ':
                p++;
                continue;
            case '+':
                p++;
                return current = Token::Plus;
            case '-':
                p++;
                return current = Token::Minus;
            case '*':
                p++;
                return current = Token::Multiply;
            case '/':
                p++;
                return current = Token::Divide;
            case '(':
                p++;
                return current = Token::LeftParenth;
            case ')':
                p++;
                return current = Token::RightParenth;
            default:
                if (isdigit(c)) {
                    while (p && isdigit(*p)) {
                        val *= 10;
                        val += *p - '0';
                        p++;
                    }
                    return current = Token::Number;
                } else {
                    throw invalid_argument("unexpected character");
                }
            }
        }
        return current = Token::Eof;
    }

    void match(Token t)
    {
        if (current != t)
            error("syntax error");
        current = next();
    }

    void factor()
    {
        switch (current) {
        case Token::LeftParenth:
            match(Token::LeftParenth);
            machine.push(Node { NodeType::LeftParenth });
            expression();
            match(Token::RightParenth);
            machine.push(Node { NodeType::RightParenth });
            break;
        case Token::Minus:
            match(Token::Minus);
            machine.push(Node { NodeType::UnaryOp, OperationType::UMinus });
            expression();
            break;
        case Token::Plus:
            match(Token::Plus);
            machine.push(Node { NodeType::UnaryOp, OperationType::UPlus });
            expression();
            break;
        case Token::Number:
            emit(val);
            match(Token::Number);
            break;
        default:
            error("unknown factor");
        }
    }

    void term()
    {
        factor();
        do {
            switch (current) {
            case Token::Multiply: multiply(); break;
            case Token::Divide: divide(); break;
            default:
                return;
            }
        } while (current != Token::Eof);
    }

    void expression()
    {
        term();
        do {
            switch (current) {
            case Token::Plus: add(); break;
            case Token::Minus: substract(); break;
            default:
                return;
            }
        } while (current != Token::Eof);
    }

    void add()
    {
        match(Token::Plus);
        term();
        machine.push(Node { NodeType::BinaryOp, OperationType::Add });
    }

    void substract()
    {
        match(Token::Minus);
        term();
        machine.push(Node { NodeType::BinaryOp, OperationType::Sub });
    }

    void multiply()
    {
        match(Token::Multiply);
        factor();
        machine.push(Node { NodeType::BinaryOp, OperationType::Mul });
    }

    void divide()
    {
        match(Token::Divide);
        factor();
        machine.push(Node { NodeType::BinaryOp, OperationType::Div });
    }

    void error(const string &msg)
    {
        throw domain_error(msg);
    }

    void emit(int v)
    {
        machine.push(Node { NodeType::Number, OperationType::None, v });
    }

    // выполнение команд
    void execStack()
    {
        while (!machine.empty()) {
            Node &t = machine.top();
            if (t.nodeType == NodeType::BinaryOp || t.nodeType == NodeType::RightParenth) {
                back.push(t);//перемещаем в правый стек
                machine.pop();
                continue;
            }
            if (t.nodeType == NodeType::LeftParenth) {
                if (back.top().nodeType != NodeType::Number)
                    error("Missing number in the back stack");
                machine.pop();
                machine.push(back.top());
                back.pop();//number
                back.pop();//rparen
                continue;
            }
            if (t.nodeType == NodeType::Number) {
                machine.pop();//number
                if (machine.empty() && back.empty()) {
                    result = t.value;
                    return;
                }
                if (!machine.empty() && machine.top().nodeType == NodeType::UnaryOp) {
                    unaryOp(t, machine.top().opType);
                    machine.pop();// u-
                    machine.push(t);//вернуть с обр. знаком
                    continue;
                }
                if (!back.empty() && back.top().nodeType == NodeType::Number) {
                    Node &op1 = t;
                    Node &op2 = back.top();
                    back.pop();//num
                    if (back.top().nodeType != NodeType::BinaryOp)
                        error("Missing binary op in the back stack");
                    binaryOp(op1, op2, back.top().opType);
                    back.pop();//operation
                    machine.push(op1);//result
                    continue;
                }
                back.push(t);//move to back from machine
            }
        }
    }

    void unaryOp(Node &op, OperationType operation)
    {
        if (operation == OperationType::UMinus)
            op.value *= -1;
    }

    void binaryOp(Node &op1, Node &op2, OperationType operation)
    {
        switch (operation) {
        case OperationType::Add: op1.value += op2.value; break;
        case OperationType::Sub: op1.value -= op2.value; break;
        case OperationType::Mul: op1.value *= op2.value; break;
        case OperationType::Div: op1.value /= op2.value; break;
        default:
            break;
        }
    }

    long calculate(const string &s)
    {
        ios_base::sync_with_stdio(false);
        result = 0;
        p = s.c_str();
        next();
        while (current != Token::Eof) {
            expression();
        }
        execStack();
        assert(machine.empty());
        assert(back.empty());
        return result;
    }
};

void test()
{
    string e1 = "-(2+3)*4*(5+(((8+9))))*-5";
    Solution s;
    cout << s.calculate(e1) << endl;
    string e2 = "2147483647";
    cout << s.calculate(e2) << endl;
}

#endif // CALC_H
