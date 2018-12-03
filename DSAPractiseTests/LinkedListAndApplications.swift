//
//  LinkedListAndApplications.swift
//  DSAPractiseTests
//
//  Created by Vinayak Parmar on 06/09/18.
//  Copyright © 2018 VMP. All rights reserved.
//

import XCTest

class LinkedListNode<T> {
    var value: T
    var nextNode: LinkedListNode?
    
    init(value: T) {
        self.value = value
    }
    
    func printList() {
        print("\nPrinting linked list")
        var tempNode: LinkedListNode<T>? = self
        while tempNode != nil {
            print(tempNode!.value, terminator: ",")
            tempNode = tempNode?.nextNode
        }
        print("")
    }
    
    func count() -> Int {
        var count = 0
        var tempNode: LinkedListNode<T>? = self
        while tempNode != nil {
            count = count + 1
            tempNode = tempNode?.nextNode
        }
        return count
    }
}

class QueueWithLinkedList<T: Initable> {
    private var frontNode: LinkedListNode<T>?
    private var rearNode: LinkedListNode<T>?
    var size = 0
    
    init() {}
    
    func enqueue(element: T) {
        size = size + 1
        
        if rearNode == nil {
            frontNode = LinkedListNode(value: element)
            rearNode = frontNode
        } else {
            let newNode = LinkedListNode(value: element)
            rearNode?.nextNode = newNode
            rearNode = newNode
        }
    }
    
    @discardableResult func dequeue() -> T? {
        if size == 0 {
            print("Queue Empty")
            return nil
        }
        let firstNode = frontNode
        frontNode = frontNode?.nextNode
        
        if frontNode == nil {
            rearNode = nil
        }
        
        return firstNode?.value
    }
}

class LinkedListAndApplications: XCTestCase {
    
    func testQueueWithLinkedlistFunctionality() {
        let queue = QueueWithLinkedList<String>()
        queue.enqueue(element: "V")
        queue.enqueue(element: "I")
        queue.enqueue(element: "N")
        queue.enqueue(element: "A")
        queue.enqueue(element: "Y")
        queue.enqueue(element: "A")
        queue.enqueue(element: "k")
        
        queue.dequeue()
        queue.dequeue()
        queue.dequeue()
        queue.dequeue()
        queue.dequeue()
        queue.dequeue()
        queue.dequeue()
        queue.dequeue()
        queue.dequeue()
        
        queue.enqueue(element: "A")
        queue.enqueue(element: "k")
    }
    
    func testAdditiontwoNumbersWithLinkedList() {
        // Reverse numbers then add them
    }
    
    func testAdditiontwoNumbersWithLinkedListRecursive() {
        
        let node1 = LinkedListNode(value: 8)
        node1.nextNode = LinkedListNode(value: 3)
        node1.nextNode?.nextNode = LinkedListNode(value: 4)
        node1.nextNode?.nextNode?.nextNode = LinkedListNode(value: 6)
        node1.nextNode?.nextNode?.nextNode?.nextNode = LinkedListNode(value: 1)
        
        let node2 = LinkedListNode(value: 2)
        node2.nextNode = LinkedListNode(value: 4)
        node2.nextNode?.nextNode = LinkedListNode(value: 7)
        node2.nextNode?.nextNode?.nextNode = LinkedListNode(value: 1)
        node2.nextNode?.nextNode?.nextNode?.nextNode = LinkedListNode(value: 9)
        
        let resultNode = add(node1: node1,
                             node2: node2)
        resultNode?.printList()
    }
    
   
    // MARK: Helper
    func add(node1: LinkedListNode<Int>,
             node2: LinkedListNode<Int>) -> LinkedListNode<Int>? {
        
        print("Adding nodes", terminator:"")
        node1.printList()
        node2.printList()
        var resultNode: LinkedListNode<Int>!

        let node1Count = node1.count()
        let node2Count = node2.count()
        
        if node1Count != node2Count {
            resultNode = addSameSizeNodes(node1: node1,
                                          node2: node2)
        } else {
            var carry = 0
            var sum = 0
            let stack = Stack<LinkedListNode<Int>>()
            
            func addSameSizeNodeRecursively(_node1: LinkedListNode<Int>?,
                                            _node2: LinkedListNode<Int>?) {
                if _node1 == nil || _node2 == nil {
                    return
                }
                
                addSameSizeNodeRecursively(_node1: _node1?.nextNode, _node2: _node2?.nextNode)
                sum = _node1!.value + _node2!.value + carry
                carry = sum / 10
                sum = sum % 10
                
                stack.push(element: LinkedListNode.init(value: sum))
            }
            addSameSizeNodeRecursively(_node1: node1, _node2: node2)
        }
        
        return resultNode
    }
    
    func addSameSizeNodes(node1: LinkedListNode<Int>,
                          node2: LinkedListNode<Int>) -> LinkedListNode<Int> {
        var resultNode: LinkedListNode<Int>!

        let stack = Stack<LinkedListNode<Int>>()
        
        var node1Head: LinkedListNode<Int>? = node1
        var node2Head: LinkedListNode<Int>? = node2
        
        while node1Head != nil || node2Head != nil {
            if resultNode == nil {
                resultNode = LinkedListNode(value: node1Head!.value + node2Head!.value)
                stack.push(element: resultNode)
            } else {
                resultNode.nextNode = LinkedListNode(value: node1Head!.value + node2Head!.value)
                resultNode = resultNode.nextNode
                stack.push(element: resultNode!)
            }
            
            node1Head = node1Head?.nextNode
            node2Head = node2Head?.nextNode
        }
        
        var carry = 0
        while !stack.isEmpty() {
            resultNode = stack.pop()
            resultNode.value = carry + resultNode.value
            
            if resultNode.value > 9 {
                resultNode.value = resultNode.value % 10
                carry = 1
            } else {
                carry = 0
            }
        }
        
        if carry == 1 {
            let newNode = LinkedListNode(value: 1)
            newNode.nextNode = resultNode
            resultNode = newNode
        }
        
        return resultNode
    }
    
    func testReverseLinkedinListAfterKthNode() {
        let k = 3
        
        let node1 = LinkedListNode(value: 8)
        node1.nextNode = LinkedListNode(value: 3)
        node1.nextNode?.nextNode = LinkedListNode(value: 4)
        node1.nextNode?.nextNode?.nextNode = LinkedListNode(value: 6)
        node1.nextNode?.nextNode?.nextNode?.nextNode = LinkedListNode(value: 1821)
        node1.nextNode?.nextNode?.nextNode?.nextNode?.nextNode = LinkedListNode(value: 234)
        node1.nextNode?.nextNode?.nextNode?.nextNode?.nextNode?.nextNode = LinkedListNode(value: 11)
        node1.nextNode?.nextNode?.nextNode?.nextNode?.nextNode?.nextNode?.nextNode = LinkedListNode(value: 12)
        node1.nextNode?.nextNode?.nextNode?.nextNode?.nextNode?.nextNode?.nextNode?.nextNode = LinkedListNode(value: 98)
        
        _ = reverse(node: node1,
                    count: 5)
    }
    
    func reverse<T>(node: LinkedListNode<T>,
                    count: Int) -> LinkedListNode<T>? {
        var currentNode: LinkedListNode<T>? = node
        var nextNode: LinkedListNode<T>?
        var nextListNode: LinkedListNode<T>?
        
        while currentNode != nil {
            nextNode = currentNode?.nextNode
            currentNode?.nextNode = nextListNode
            nextListNode = currentNode
            currentNode = nextNode
        }
        
        return currentNode
    }
}
