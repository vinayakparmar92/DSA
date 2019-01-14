//
//  DSAPractiseTests.swift
//  DSAPractiseTests
//
//  Created by Vinayak Parmar on 28/08/18.
//  Copyright © 2018 VMP. All rights reserved.
//

import XCTest
@testable import DSAPractise

protocol PizzaProtocol {
    var price: Int {get set}
}

class CommonAlgos: XCTestCase {
    
    func testMinimumElementFromASortedRotatedArray() {
        func findMinElementUsingBinarySearch(numbers:[Int],
                                             left: Int,
                                             right: Int) -> Int {
            // Case when only element exist
            if numbers[left] == numbers[right] {
                return numbers[left]
            }
            
            // Array is already sorted
            if numbers[left] < numbers[right] {
                return numbers[left]
            }
            
            // Array is not rotated
            let mid = (left + right) / 2
            if numbers[mid] < numbers[left] {
                return findMinElementUsingBinarySearch(numbers: numbers,
                                                       left: left,
                                                       right: mid)
            } else {
                return findMinElementUsingBinarySearch(numbers: numbers,
                                                       left: mid + 1,
                                                       right: right)
            }
        }
        
        let elements = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let minimumElement = findMinElementUsingBinarySearch(numbers: elements,
                                                             left: 0,
                                                             right: elements.count - 1)
        print("Minimum element \(minimumElement)")
        
        let elements1 = [6,7,8,9,1,2,3,4,5]
        let minimumElement1 = findMinElementUsingBinarySearch(numbers: elements1,
                                                              left: 0,
                                                              right: elements.count - 1)
        print("Minimum element \(minimumElement1)")
        
        let elements2 = [8,9,1,2,3,4,5,6,7]
        let minimumElement2 = findMinElementUsingBinarySearch(numbers: elements2,
                                                              left: 0,
                                                              right: elements.count - 1)
        print("Minimum element \(minimumElement2)")
        
        let elements3 = [9,1,2,3,4,5,6,7,8]
        let minimumElement3 = findMinElementUsingBinarySearch(numbers: elements3,
                                                              left: 0,
                                                              right: elements.count - 1)
        print("Minimum element \(minimumElement3)")
    }
    
    func testStringPrintOfLength() {
        let countLetters = 4
        var letters = Array.init(repeating: -1,
                                 count: countLetters)
        
        func printString(length: Int, totalLetters: Int) {
            if length == 0 {
                print(letters)
            } else {
                for index in 0..<totalLetters {
                    letters[length - 1] = index
                    printString(length: length - 1, totalLetters: totalLetters)
                }
            }
        }
        
        printString(length: countLetters, totalLetters: 2)
    }
    
    func testFibonacciSeriesWithRecursion() {
        func fibonacciNumbers(count: Int) -> Int {
            if count <= 1 {
                return 1
            } else {
                let sum = fibonacciNumbers(count: count - 2) + fibonacciNumbers(count: count - 1)
                return sum
            }
        }
        
        for index in 0..<10 {
            print(fibonacciNumbers(count: index), terminator: ",")
        }
    }
    
    func testTowerOfHanoi() {
        moveInTowerOfHanoi(disc: 3, fromRod: 1, auxRod: 2, destRod: 3)
    }
    
    func testXOR() {
        let numbers = [1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,10]
        var result = 0
        numbers.forEach { (num) in
            result = result ^ num
        }
        print("XOR Result \(result)")
    }
    
    // MARK: HELPER METHODS
    func moveInTowerOfHanoi(disc: Int,
                            fromRod: Int, auxRod: Int, destRod: Int) {
        if disc == 1 {
            print("Moved Disc \(1) from \(fromRod) to \(destRod)")
        } else {
            moveInTowerOfHanoi(disc: disc - 1,
                               fromRod: fromRod,
                               auxRod: auxRod,
                               destRod: destRod)
            print("Moved Disc \(disc) from \(fromRod) to \(destRod)")
            moveInTowerOfHanoi(disc: disc - 1,
                               fromRod: auxRod,
                               auxRod: destRod,
                               destRod: fromRod)
        }
    }
    
    func testWindowSlidingAlgo() {
        
        let K = 2 // Window length
        let numbers = [4,6,2,6,1,8,9,2,3]
        
        var firstWindowSum = 0
        for index in 0..<K {
            firstWindowSum = firstWindowSum + numbers[index]
        }
        
        var maxSum = firstWindowSum
        var tempSum = firstWindowSum
        for index in 1...numbers.count - K - 1 {
            tempSum = tempSum - numbers[index - 1] + numbers[index + K - 1]
            
            if tempSum > maxSum {
                maxSum = tempSum
            }
        }
        
        print("Max in numbers \(numbers) is \(maxSum)")
    }
    
    func testMinimumDeviationAlgo() {
        let K = 20
        let numbers = [4,6,2,6,1,8,9,2,3]
        var i: Int = 0, j = 0, currDiff = 0, prevDiff = 0, sum = 0
        
        while i < numbers.count {
            sum = sum + numbers[i]
            currDiff = K - sum
            
            if currDiff <= 0 {
                if prevDiff < currDiff {
                    
                } else {
                    
                }
            } else {
                j += 1
            }
        }
    }
    
    func testCommonFuncitonalities() {
        // Checking computed property functionality
        var computedProperty: Int {
            get {
                return 10
            }
            set {
                print("Trying to set property \(newValue)")
            }
        }
        
        computedProperty = 100
        print("Printing computed property \(computedProperty)")
        
        // Checking constant values in an initialiser
        class tempp {
            let name: String
            
            init(_ firstName: String, _ lastName: String) {
                self.name = firstName
                // self.name = lastName // Error
            }
        }
    }
    
    func testDecoraterDesignPattern() {
        class ClassicPizza: Pizza {
            var price: Int = 100
            
            func printPrice() {
                print("Prices is \(price)")
            }
        }
        
        class ToppedPizza: Pizza {
            var price: Int = 50
            var basePizza: Pizza?
            
            init(basePizza: Pizza) {
                self.basePizza = basePizza
            }
            
            func printPrice() {
                print("Prices is \(price + basePizza!.price)")
            }
        }
    }
    
    func testSlidingWindowAlgo() {
        // Given an array and a number K, find a sub array which is closest to K
        // Assuming all number are positive
        
        func getSubArrayFrom(elements: [Int],
                             withSumCloseToNumber K: Int) {
            var left: Int = 0,
            right: Int = 0,
            sum: Int = elements[0],
            diff: Int = 0, prevDiff: Int = 0
            var result: (leftNo: Int, rightNo: Int, summ: Int) = (0, 0, 0)
            
            while left <= right {
                prevDiff = diff
                diff = K - sum
                
                if diff == 0 {
                    result = (left, right - 1, diff)
                    break
                } else if diff < 0 {
                    if abs(diff) < abs(prevDiff) {
                        result = (left, right, diff)
                    } else {
                        result = (left, right-1, prevDiff)
                    }
                    sum -= (elements[left] + elements[right])
                    left += 1
                } else {
                    sum += elements[right]
                    
                    if right + 1 != elements.count {
                        right += 1
                    }
                }
            }
            
            print("Sum closest to \(K) is \(result.summ)")
            print("Elements are")
            for index in result.leftNo...result.rightNo {
                print("\(elements[index])", terminator: "")
            }
            print("\n")
        }
        
        getSubArrayFrom(elements: [1,3,7,10,15],
                        withSumCloseToNumber: 15)
    }
    
    func testCocurrentAccessWithLimit() {
        let sema = DispatchSemaphore.init(value: 3)
        
        sema.wait()
        for index in 0..<15 {
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3) {
                print("BLABLA \(index)")
                sema.signal()
            }
        }
    }
    
    func testAllPermutationsOfString() {
        
        func printPermutationsOf(str: String) {
            // Handle edge cases
            if str.isEmpty {
                return
            }
            
            
            
            
        }
        
        printPermutationsOf(str: "vinayak")
        printPermutationsOf(str: "")
        printPermutationsOf(str: "65432")
        printPermutationsOf(str: "01")
        printPermutationsOf(str: "0101")
    }
    
    func testStringToNumber() {
        
    }
    
    func stringToNumber(number: String, mutiplierPower: Int, result: Int) -> Int {
        if number.count == 0 {
            return result
        } else {
            
            let multiplier = 10 ^ mutiplierPower
            let digit = number[multiplier]
            let resultTemp = result + multiplier * digit
            
            return stringToNumber(number: ,
                    mutiplierPower:,
                    result:)
        }
    }
}

protocol Pizza {
    var price: Int {get set}
    func printPrice()
}
