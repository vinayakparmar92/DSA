//
//  QueueAndApplications.swift
//  DSAPractiseTests
//
//  Created by Vinayak Parmar on 06/09/18.
//  Copyright © 2018 VMP. All rights reserved.
//

import XCTest

class Queue<T: Initable> {
    private var elements = [T]()
    var front = 0
    var rear = 0
    var size = 0
    private var capacity = 0
    
    init(capacity: Int) {
        elements = Array(repeating: T(),
                         count: capacity)
                
        self.capacity = capacity
        front = 0
        rear = 0
    }
    
    func enqueue(element: T) {
        if size == capacity {
            print("Queue Full")
            return
        }
        size = size + 1
        rear = (rear + 1) % capacity
        elements[rear] = element
    }
    
    @discardableResult func dequeue() -> T? {
        if size == 0 {
            print("Queue Empty")
            return nil
        }
        front = (front + 1) % capacity

        let element = elements[front]
        elements[front] = T()

        size = size - 1

        return element
    }
}

class QueueAndApplications: XCTestCase {
    func testQueueFunctionality() {
        let queue = Queue<String>(capacity: 10)
        queue.enqueue(element: "V")
        queue.enqueue(element: "I")
        queue.dequeue()
        queue.dequeue()
    }    
}
