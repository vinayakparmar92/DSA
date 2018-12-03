//
//  StackAndApplications.swift
//  DSAPractiseTests
//
//  Created by Vinayak Parmar on 06/09/18.
//  Copyright © 2018 VMP. All rights reserved.
//

import XCTest

class Stack<T> {
    private var elements = [T]()
    private var top: Int = -1
    
    func pop() -> T {
        let element = elements[top]
        elements.remove(at: top)
        top = top - 1
        return element
    }
    
    func peek() -> T {
        return elements[top]
    }
    
    func push(element: T) {
        elements.append(element)
        top = top + 1
    }
    
    func isEmpty() -> Bool {
        return top == -1
    }
}

class DoubleStack<T> {
    private var elements = [T]()
    private var topOne: Int = -1
    private var topTwo: Int = 50
    
    func popOne() -> T {
        let element = elements[topOne]
        elements.remove(at: topOne)
        topOne = topOne - 1
        return element
    }
    
    func peekOne() -> T {
        return elements[topOne]
    }
    
    func pushOne(element: T) {
        elements.append(element)
        topOne = topOne + 1
    }
    
    func isEmptyOne() -> Bool {
        return topOne == -1
    }
    
    func popTwo() -> T {
        let element = elements[topTwo]
        elements.remove(at: topTwo)
        topTwo = topTwo - 1
        return element
    }
    
    func peekTwo() -> T {
        return elements[topTwo]
    }
    
    func pushTwo(element: T) {
        elements.append(element)
        topTwo = topTwo - 1
    }
    
    func isEmptyTwo() -> Bool {
        return topTwo == -1
    }
}

class StackAndApplications: XCTestCase {
    
    func testInfixToPostfixConvert() {
        let inputExpression = "(A * (B + (C / D) ) )"
        _ = getPostfixFromInfix(infixExpression: inputExpression)
    }
    
    func testPostFixEvaluation() {
        let inputExpression = "231*+9-"
        let postfixExpression = getPostfixFromInfix(infixExpression: inputExpression)
        print("RESULT \(evaluate(postfixExpression: postfixExpression))")
    }

    // MARK: Helpers
    func calculate(mathOperator: Character,
                   num1: Float, num2: Float) -> Float {
        
        switch mathOperator {
        case "*":
            return num1 * num2
        case "-":
            return num1 - num2
        case "/":
            return num1 / num2
        case "+":
            return num1 + num2
        default:
            return 0.0
        }
    }
    
    // Converting InfixToPostfix expressions us ing Stacks
    func getPostfixFromInfix(infixExpression: String) -> String{
        let expressionsStack = Stack<Character>()
        var result = ""
        
        for letter in infixExpression {
            if letter.isLetterOrDigit() {
                result.append(letter)
                
            } else if letter.isBracket() {
                if letter == "(" {
                    result.append(letter)
                    expressionsStack.push(element: letter)
                } else {
                    while (!expressionsStack.isEmpty() && expressionsStack.peek() != "(") {
                        result.append(expressionsStack.pop())
                    }
                    result.append(letter)
                    
                    if !expressionsStack.isEmpty() {
                        _ = expressionsStack.pop()
                    }
                }
            } else if letter.isOperator() {
                if expressionsStack.isEmpty() {
                    expressionsStack.push(element: letter)
                } else {
                    while !expressionsStack.isEmpty() &&
                        letter.precedence <= expressionsStack.peek().precedence &&
                        expressionsStack.peek() != "(" {
                            result.append(expressionsStack.pop())
                    }
                    expressionsStack.push(element: letter)
                }
            }
        }
        
        while !expressionsStack.isEmpty() {
            result.append(expressionsStack.pop())
        }
        
        return result
    }
    
    func evaluate(postfixExpression: String) -> Float {
        let stack = Stack<Float>()
        
        for letter in postfixExpression {
            if letter.isLetterOrDigit(),
                let number = Float(String.init(letter)){
                stack.push(element: number)
                
            } else if letter.isOperator() {
                let num2 = stack.pop()
                let num1 = stack.pop()
                
                let result = calculate(mathOperator: letter,
                                       num1: num1, num2: num2)
                stack.push(element: result)
            }
        }
        
        return stack.pop()
    }
}
