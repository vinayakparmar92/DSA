//
//  SortingTestCases.swift
//  DSAPractiseTests
//
//  Created by Vinayak Parmar on 06/09/18.
//  Copyright © 2018 VMP. All rights reserved.
//

import XCTest

class SortingAlgos: XCTestCase {
 
    var numbers = [3,47,9,4,78,90,34,56,2]
    var sortedNumbers = [1,2,3,4,5,6,7,8,9,10,19,123]
    
    // Complexity O(n * Logn) best and worstcase
    // Stable sorting
    func testMergeSort() {
        
        func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
            guard array.count > 1 else { return array }
            
            let middleIndex = array.count / 2
            
            let leftArray = mergeSort(Array(array[0..<middleIndex]))
            let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
            
            return merge(leftArray, rightArray)
        }
        
        func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
            var leftIndex = 0
            var rightIndex = 0
            
            var orderedArray: [T] = []
            
            while leftIndex < left.count && rightIndex < right.count {
                let leftElement = left[leftIndex]
                let rightElement = right[rightIndex]
                
                if leftElement < rightElement {
                    orderedArray.append(leftElement)
                    leftIndex += 1
                } else if leftElement > rightElement {
                    orderedArray.append(rightElement)
                    rightIndex += 1
                } else {
                    orderedArray.append(leftElement)
                    leftIndex += 1
                    orderedArray.append(rightElement)
                    rightIndex += 1
                }
            }
            
            while leftIndex < left.count {
                orderedArray.append(left[leftIndex])
                leftIndex += 1
            }
            
            while rightIndex < right.count {
                orderedArray.append(right[rightIndex])
                rightIndex += 1
            }
            
            return orderedArray
        }
        
        print("\n Merge sorting: \(numbers)")
        numbers = mergeSort(numbers)
        print("\n After Merge sorting: \(numbers)")
    }
    
    // Stable
    // Best case, Worst case, Average case = O(n^2)
    // Add elements one by one to a sub array. Make sure the new element gets added to the
    // correct position(smaller and bigger than right and left resp).
    func testInsertionSort() {
        print("\nInsertion Sorting: \(numbers)", terminator: "")
        
        var j = 0, currentElement = numbers[0]
        
        for index in 1..<numbers.count {
            j = index
            currentElement = numbers[index]
            
            while (j != 0) {
                if currentElement < numbers[j - 1] {
                    numbers[j] = numbers[j-1]
                    j -= 1
                } else {
                    break
                }
            }
            
            numbers[j] = currentElement
        }
        
        print("\nAfter Insertion Sorting: \(numbers)", terminator: "\n")
    }
    
    // Best case, Worst case, Average case = O(n^2)
    // Not stable
    func testSelectionSort() {
        print("\nSelection Sorting: \(numbers)",
            terminator: "")
        
        var minimumElementIndex = 0
        
        for index in 0..<numbers.count {
            minimumElementIndex = index

            for newIndex in (index + 1)..<numbers.count {
                if numbers[newIndex] < numbers[minimumElementIndex] {
                    minimumElementIndex = newIndex
                }
            }
            
            let temp = numbers[minimumElementIndex]
            numbers[minimumElementIndex] = numbers[index]
            numbers[index] = temp
        }
        
        print("\nAfter Selection Sorting: \(numbers)",
            terminator: "\n")
    }
    
    // Best case, Worst case, Average case = O(n^2)
    // Not stable
    func testBubbleSort() {
        print("\nBubble Sorting: \(numbers)", terminator: "")
        
        for _ in 0..<numbers.count - 1 {
            for newIndex in 0..<numbers.count - 1 {
                if numbers[newIndex] > numbers[newIndex + 1] {
                    let temp = numbers[newIndex]
                    numbers[newIndex] = numbers[newIndex + 1]
                    numbers[newIndex + 1] = temp
                }
            }
        }
        
        print("\nAfter Bubble Sorting: \(numbers)", terminator: "\n")
    }
    
    // Perfect solution for sorted array
    // Best case = O(n), Worst case, Average case = O(n^2)
    func testImprovedBubbleSort() {
        print("\nBubble Sorting: \(sortedNumbers)", terminator: "")
        
        var wasAnyNumberSwapped = true
        
        for _ in 0..<sortedNumbers.count - 1 {
            if wasAnyNumberSwapped {
                wasAnyNumberSwapped = false
                
                for newIndex in 0..<sortedNumbers.count - 1 {
                    if sortedNumbers[newIndex] > sortedNumbers[newIndex + 1] {
                        let temp = sortedNumbers[newIndex]
                        sortedNumbers[newIndex] = sortedNumbers[newIndex + 1]
                        sortedNumbers[newIndex + 1] = temp
                        
                        wasAnyNumberSwapped = true
                    }
                }
            }
        }
        
        print("\nAfter Bubble Sorting: \(numbers)", terminator: "\n")
    }
    
    func testHeapSort() {
     
        func heapSort() {
            
        }
    }
    
    func testQuickSort() {
        func quickSort(elements: inout [Int], leftIndex: Int, rightIndex: Int) {
            if leftIndex < rightIndex {
                let partitionIndex = partition(elements: &elements,
                                               leftIndex: leftIndex,
                                               rightIndex: rightIndex)
                quickSort(elements: &elements,
                          leftIndex: leftIndex,
                          rightIndex: partitionIndex)
                quickSort(elements: &elements,
                          leftIndex: partitionIndex + 1,
                          rightIndex: rightIndex)
            }
        }
        
        func partition(elements: inout [Int],
                       leftIndex: Int,
                       rightIndex: Int) -> Int {
            var i = 0,
            j = rightIndex + 1
            let pivotElement = elements[leftIndex]
            
            while i < j {
                // Find the element bigger than pivot
                repeat {
                    i += 1
                } while (elements[i] <= pivotElement)
                
                // Find the element smaller than pivot
                repeat {
                    j -= 1
                } while (elements[j] > pivotElement)
                
                if i < j {
                    let temp = elements[i]
                    elements[i] = elements[j]
                    elements[j] = temp
                }
            }

            let temp = elements[leftIndex]
            elements[leftIndex] = elements[j]
            elements[j] = temp

            return j
        }
        
        print("\n Quick sorting: \(numbers)")
        quickSort(elements: &numbers,
                  leftIndex: 0,
                  rightIndex: numbers.count - 1)
        print("\n After Quick sorting: \(numbers)")
    }
    
    func quickSort(elements: inout [Int], leftIndex: Int, rightIndex: Int) {
        if rightIndex > leftIndex {
            let pivotElement = elements[(leftIndex + rightIndex) / 2]
            
            let pivotIndex = partition(elements: &elements,
                                       leftIndex: leftIndex,
                                       rightIndex: rightIndex,
                                       pivotElement: pivotElement)
            
            quickSort(elements: &elements, leftIndex: leftIndex, rightIndex: pivotIndex - 1)
            quickSort(elements: &elements, leftIndex: pivotIndex + 1, rightIndex: rightIndex)
        }
    }
    
    func partition( elements: inout [Int],
                   leftIndex: Int,
                   rightIndex: Int,
                   pivotElement: Int) -> Int {
        
        var leftIndexTemp = leftIndex
        var rightIndexTemp = rightIndex
        
        while leftIndexTemp < rightIndexTemp {
            
            repeat {
                leftIndexTemp += 1
            } while(elements[leftIndexTemp] < pivotElement)
            
            repeat {
                rightIndexTemp += 1
            } while(elements[rightIndexTemp] > pivotElement)
            
            if leftIndexTemp < rightIndexTemp {
                let temp = elements[leftIndexTemp]
                elements[leftIndexTemp] = elements[rightIndexTemp]
                elements[rightIndexTemp] = temp
            }
        }
        
        let temp = elements[rightIndexTemp]
        elements[rightIndexTemp] = pivotElement
        
        return rightIndexTemp
    }    
}
