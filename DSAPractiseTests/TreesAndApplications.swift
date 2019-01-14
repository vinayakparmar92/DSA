//
//  TreesAndApplications.swift
//  DSAPractiseTests
//
//  Created by Vinayak Parmar on 06/09/18.
//  Copyright © 2018 VMP. All rights reserved.
//

import XCTest

extension TreeNode: Initable {}

class TreeNode<T: Comparable> {
    var value : T
    var leftNode: TreeNode?
    var rightNode: TreeNode?
    
    required init() {
        value = 0 as! T
    }
    
    init(value: T) {
        self.value = value
    }
    
    func insert(value: T) {
        if self.value >= value {
            if leftNode == nil {
                leftNode = TreeNode(value: value)
            } else {
                leftNode?.insert(value: value)
            }
        } else {
            if rightNode == nil {
                rightNode = TreeNode(value: value)
            } else {
                rightNode?.insert(value: value)
            }
        }
    }
    
    func contains(value: T) -> Bool {
        if self.value == value {
            return true
        } else if self.value < value {
            if leftNode == nil {
                return false
            } else {
                return leftNode!.contains(value: value)
            }
        } else {
            if rightNode == nil {
                return false
            } else {
                return rightNode!.contains(value: value)
            }
        }
    }
    
    func traverseTreeInorder() {
        if leftNode != nil {
            leftNode?.traverseTreeInorder()
        }
        print(value, terminator:",")
        if rightNode != nil {
            rightNode?.traverseTreeInorder()
        }
    }
    
    func traverseTreePreorder() {
        print(value, terminator:",")
        if leftNode != nil {
            leftNode?.traverseTreePreorder()
        }
        if rightNode != nil {
            rightNode?.traverseTreePreorder()
        }
    }
    
    func traverseTreePostorder() {
        if leftNode != nil {
            leftNode?.traverseTreePostorder()
        }
        if rightNode != nil {
            rightNode?.traverseTreePostorder()
        }
        print(value, terminator:",")
    }
    
    class func mirrorTree(rootNode: TreeNode?) {
        if rootNode == nil {
            return
        }
        let newTreeRootNode = rootNode
        
        let leftNode = newTreeRootNode?.leftNode
        newTreeRootNode?.leftNode = newTreeRootNode?.rightNode
        newTreeRootNode?.rightNode = leftNode
        
        mirrorTree(rootNode: newTreeRootNode?.leftNode)
        mirrorTree(rootNode: newTreeRootNode?.rightNode)
    }
    
    class func traversePreorderWithoutRecursion(rootNode: TreeNode?) {
        let stack = Stack<TreeNode>()
        var rootNode = rootNode
        
        while true {
            while rootNode != nil {
                print(rootNode!.value, terminator: ",") // Printing the Root element
                
                stack.push(element: rootNode!)
                
                rootNode = rootNode!.leftNode
            }
            
            if stack.isEmpty() {
                break
            }
            
            rootNode = stack.pop()
            rootNode = rootNode?.rightNode
        }
    }
    
    class func traverseInorderWithoutRecursion(rootNode: TreeNode?) {
        let stack = Stack<TreeNode>()
        var rootNode = rootNode
        
        while true {
            // Traversing all left nodes for current root node
            while rootNode != nil {
                if rootNode?.leftNode == nil {
                    print(rootNode!.value, terminator:",")
                    rootNode = nil
                    
                } else {
                    stack.push(element: rootNode!)
                    rootNode = rootNode!.leftNode
                }
            }
            
            if stack.isEmpty() {
                break
            }
            
            rootNode = stack.pop()
            print(rootNode!.value, terminator:",")
            rootNode = rootNode?.rightNode
        }
    }
    
    class func traverseBFS(_rootNode: TreeNode?,
                           capacity: Int) {
        let queue = Queue<TreeNode>(capacity: capacity)
        var rootNode = _rootNode
        
        if rootNode != nil {
            print(rootNode!.value, terminator: ",")
        } else {
            return
        }
        
        while rootNode != nil {
            if rootNode?.leftNode != nil {
                queue.enqueue(element: (rootNode?.leftNode)!)
            }
            if rootNode?.rightNode != nil {
                queue.enqueue(element: (rootNode?.rightNode)!)
            }
            
            let leftNode = rootNode?.leftNode
            let rightNode = rootNode?.rightNode
            
            rootNode = leftNode
            if rootNode == nil {
                rootNode = rightNode
            }
        }
        
        while queue.size != 0 {
            print(queue.dequeue()!.value, terminator: ",")
        }
        print("\n")
    }
    
    class func topViewOfTree(rootNode: TreeNode?) {
        if rootNode == nil {
            print("Tree empty")
        }
        
        let stack = Stack<TreeNode>()
        let queue = Queue<TreeNode>(capacity: 10)
        
        var temp = rootNode
        
        while temp != nil {
            stack.push(element: temp!)
            temp = temp?.leftNode
        }
        // Printing the first hald
        while !stack.isEmpty() {
            print("\(stack.pop().value)", terminator: ",")
        }
        
        if rootNode?.rightNode != nil {
            var temp = rootNode?.rightNode
            
            while temp != nil {
                queue.enqueue(element: temp!)
                temp = temp?.rightNode
            }
        }
        
        // Printing the second half
        while queue.size != 0 {
            print("\(queue.dequeue()!.value)", terminator: ",")
        }
    }
}

class BinaryMinHeap {
    private var elements = [Int]()
    var size = 0
    var rootIndex = 0
    var capacity = 0
    
    init(capacity: Int) {
        self.capacity = capacity
        elements = Array(repeating: -1, count: capacity)
    }
    
    func parentFor(index: Int) -> Int {
        return Int((index - 1) / 2)
    }
    
    func leftChildFor(index: Int) -> Int {
        return 2 * index + 1
    }
    
    func rightChildFor(index: Int) -> Int {
        return 2 * index + 2
    }
    
    func leftChildElement(index: Int) -> Int? {
        if leftChildFor(index: rootIndex) <= size - 1 {
            return elements[leftChildFor(index: rootIndex)]
        }
        return nil
    }
    
    func rightChildElement(index: Int) -> Int? {
        if rightChildFor(index: rootIndex) <= size - 1 {
            return elements[rightChildFor(index: rootIndex)]
        }
        return nil
    }
    
    func insert(value: Int) {
        elements[size] = value
        size = size + 1
        heapifyUp()
    }
    
    func heapifyUp() {
        var index = size - 1
        
        while index != 0 && elements[parentFor(index: index)] > elements[index] {
            swap(index1: parentFor(index: index), index2: index)
            index = parentFor(index: index)
        }
    }
    
    func heapifyDown(rootElement: Int) {
        // Check if left child exist
        if (leftChildElement(index: rootElement) != nil) {
            if elements[rootElement] > leftChildElement(index: rootElement)! {
                swap(index1: rootElement, index2: leftChildFor(index: rootElement))
                heapifyDown(rootElement: leftChildFor(index: rootElement))
                
            } else if let rightChild = rightChildElement(index: rootElement),
                rightChild > elements[rootElement] {
                swap(index1: rootElement, index2: rightChildFor(index: rootElement))
                heapifyDown(rootElement: rightChildFor(index: rootElement))
            }
        }
    }
    
    func swap(index1: Int, index2: Int) {
        let temp = elements[index1]
        elements[index1] = elements[index2]
        elements[index2] = temp
    }
    
    func getMin() -> Int {
        return elements[0]
    }
    
    func extractMin() -> Int {
        let minElement = elements[rootIndex]
        elements[rootIndex] = elements[size]
        size = size - 1
        
        heapifyDown(rootElement: rootIndex)
        return minElement
    }
    
    func traverse() {
        print("Printing Elements")
        
        for element in elements {
            print(element)
        }
    }
}

class TreesAndApplications: XCTestCase {
    
    var rootNodeBST: TreeNode<Int>?
    var rootNodeBinaryTree: TreeNode<Int>?
    
    override func setUp() {
            /*
                   50
             /           \
           (25           123)
         /    \        /    \
       (12    43)   (120   130)
       /  \    /     /
     (1   24)(41)(122)
    /  \
   (0  9)
      /
    (8)
         */
        
        rootNodeBST = TreeNode.init(value: 50)
        rootNodeBST?.insert(value: 25)
        rootNodeBST?.insert(value: 123)
        rootNodeBST?.insert(value: 12)
        rootNodeBST?.insert(value: 24)
        rootNodeBST?.insert(value: 43)
        rootNodeBST?.insert(value: 41)
        rootNodeBST?.insert(value: 1)
        rootNodeBST?.insert(value: 9)
        rootNodeBST?.insert(value: 8)
        rootNodeBST?.insert(value: 0)
        rootNodeBST?.insert(value: 120)
        rootNodeBST?.insert(value: 130)
        rootNodeBST?.insert(value: 122)
        
        
        rootNodeBinaryTree = TreeNode.init(value: 50)
        rootNodeBinaryTree?.leftNode = TreeNode.init(value: 13)
        rootNodeBinaryTree?.leftNode?.leftNode = TreeNode.init(value: 23)
        rootNodeBinaryTree?.leftNode?.rightNode = TreeNode.init(value: 501)
        rootNodeBinaryTree?.leftNode?.rightNode?.leftNode = TreeNode.init(value: 52)
        rootNodeBinaryTree?.leftNode?.rightNode?.leftNode = TreeNode.init(value: 10)
        rootNodeBinaryTree?.rightNode?.rightNode?.leftNode = TreeNode.init(value: 42)
        rootNodeBinaryTree?.rightNode?.rightNode?.leftNode?.rightNode = TreeNode.init(value: 12)
        rootNodeBinaryTree?.rightNode?.rightNode?.rightNode?.rightNode = TreeNode.init(value: 123)
        rootNodeBinaryTree?.rightNode?.rightNode?.leftNode?.leftNode = TreeNode.init(value: 121)
        rootNodeBinaryTree?.leftNode?.leftNode = TreeNode.init(value: 102)
    }
    
    func testTreeTraversals() {
        print("Traversing in PostOrder")
        rootNodeBST?.traverseTreePostorder()
        print("\n")
        
        print("Traversing in PreOrder")
        rootNodeBST?.traverseTreePreorder()
        print("\n")
        
        print("Traversing in InOrder")
        rootNodeBST?.traverseTreeInorder()
        print("\n")
        
        print("Traversing in preorder without recusrion")
        TreeNode.traversePreorderWithoutRecursion(rootNode: rootNodeBST)
        print("\n")
        
        print("Traversing in inorder without recusrion")
        TreeNode.traverseInorderWithoutRecursion(rootNode: rootNodeBST)
        print("\n")
        
        print("Traversing in BFS without recusrion")
        TreeNode.traverseBFS(_rootNode: rootNodeBST, capacity: 10)
        print("\n")
    }
    
    func testTreeMirroring() {
        print("Before Mirroring")
        rootNodeBST?.traverseTreeInorder()
        print("\n")
        
        print("After Mirroring")
        TreeNode.mirrorTree(rootNode: rootNodeBST)
        rootNodeBST?.traverseTreeInorder()
        print("\n")
    }
    
    func testSearchFunctionality() {
        print("Contains 123? \(rootNodeBST?.contains(value: 123))")
        print("Contains 1234? \(rootNodeBST?.contains(value: 1234))")
        print("Contains 25? \(rootNodeBST?.contains(value: 25))")
    }
    
    func testTopViewOfTreeUsingStackQueue() {
        print("Top of Binary tree")
        TreeNode.topViewOfTree(rootNode: rootNodeBST)
    }
    
    func testPrintTreeTraverseInVerticalOrder() {
        let queue = Queue<TreeNode<Int>>(capacity: 15)
        var horizontalDistance = [Int: Int]()
        var temp = rootNodeBST
        
        if temp != nil {
            queue.enqueue(element: temp!)
            horizontalDistance[0] = temp!.value
            
            while queue.size != 0 {
                temp = queue.dequeue()
                print(temp!.value, terminator: ", ")
                
                if temp?.leftNode != nil {
                    horizontalDistance[(temp?.leftNode?.value)!] = horizontalDistance[(temp?.value)!]! - 1
                    queue.enqueue(element: (temp?.leftNode)!)
                }
                
                if temp?.rightNode != nil {
                    horizontalDistance[(temp?.rightNode?.value)!] = horizontalDistance[(temp?.value)!]! + 1
                    queue.enqueue(element: (temp?.rightNode)!)
                }
            }
        
        } else {
            print("No elements in tree")
        }
    }
    
    func testVerticalTraversalUsingRecursion() {
        
        // Find the maximum horizontal distance between left
        var maxHD = Int.min
        var minHD = Int.max
        
        func findMaxMinHDFromTreeWith(rootNode: TreeNode<Int>?,
                                      min: Int, max: Int,
                                      hd: Int) {
            if rootNode == nil {
                return
            } else {
                if hd < minHD {
                    minHD = hd
                }
                
                if hd > maxHD {
                    maxHD = hd
                }
                
                findMaxMinHDFromTreeWith(rootNode: rootNode?.leftNode,
                                         min: minHD, max: maxHD,
                                         hd: hd - 1)
                findMaxMinHDFromTreeWith(rootNode: rootNode?.rightNode,
                                         min: minHD, max: maxHD,
                                         hd: hd + 1)
            }
        }
        
        // Calulate the minimum and the maximum distance
        findMaxMinHDFromTreeWith(rootNode: rootNodeBST,
                                 min: minHD, max: maxHD, hd: 0)
        
        // Print the nodes at each line number
        func printNodesOfLevel(rootNode: TreeNode<Int>?,
                               lineNo: Int, hd: Int) {
            if rootNode == nil {
                return
            } else {
                if lineNo == hd {
                    print("\((rootNode?.value)!), ", terminator: "")
                }
                
                printNodesOfLevel(rootNode: rootNode?.leftNode,
                                  lineNo: lineNo,
                                  hd: hd - 1)
                printNodesOfLevel(rootNode: rootNode?.rightNode,
                                  lineNo: lineNo,
                                  hd: hd + 1)
            }
        }
        
        print("Max Distance \(maxHD)")
        print("Min Distance \(minHD)")

        // Print numbers with same level each time
        for index in minHD...maxHD {
            print("Elements at level \(index)")
            printNodesOfLevel(rootNode: rootNodeBST, lineNo: index, hd: 0)
            print("")
        }
    }
    
    func testTopViewOfTreeUsingHorizontalDistance() {
        struct TreeNodeQueueObj: Initable {
            let node: TreeNode<Int>
            let hd: Int
            
            init() {
                node = TreeNode(value: 23)
                hd = 0
            }
            
            init(node: TreeNode<Int>, hd: Int) {
                self.node = node
                self.hd = hd
            }
        }
        
        let queue = Queue<TreeNodeQueueObj>(capacity: 15)
        var horizontalDistance = [Int: Int]()
        var temp: TreeNodeQueueObj? = TreeNodeQueueObj(node: rootNodeBST!, hd: 0)
        
        queue.enqueue(element: temp!)
        horizontalDistance[0] = (temp?.node.value)!
        
        while queue.size != 0 {
            temp = queue.dequeue()
            
            if horizontalDistance[temp!.hd] == nil {
               horizontalDistance[temp!.hd] = temp?.node.value
            }
            
            if temp?.node.leftNode != nil {
                queue.enqueue(element: TreeNodeQueueObj(node: (temp?.node.leftNode)!,
                                                        hd: temp!.hd - 1))
            }
            
            if temp?.node.rightNode != nil {
                queue.enqueue(element: TreeNodeQueueObj(node: (temp?.node.rightNode)!,
                                                        hd: temp!.hd + 1))
            }
        }
        
        horizontalDistance.keys.forEach { (key) in
            print("\(horizontalDistance[key]!)", terminator: ", ")
        }
    }
    
    func testCommonAncestors() {
        func findCommonAncestorsFrom(node: TreeNode<Int>?,
                                     value1: Int, value2: Int) {
            // Check if root node is null
            guard let rootNode = node else {
                print("No common ancestors")
                return
            }
            
            // Check if tree contains both the values
            // <CODE>
            
            var nodeOfValue1: TreeNode<Int>? = nil
            var nodeOfValue2: TreeNode<Int>? = nil
            var currentNode = node
            var previousNode: TreeNode<Int>? = nil
            var min = value1
            var max = value2
            
            if value1 <= value2 {
                min = value1
                max = value2
            } else {
                min = value2
                max = value1
            }
            
            while true {
                if let currentNodeValue = currentNode?.value {
                    if currentNodeValue < min,
                        currentNodeValue < max {
                        currentNode = currentNode?.rightNode
                        
                    } else if currentNodeValue > min,
                        currentNodeValue > max {
                        currentNode = currentNode?.leftNode

                    } else {
                        break
                    }
                }
                
                if currentNode == nil {
                    break
                }
            }
            
            if currentNode == nil {
                print("No common ancestor")
                
            } else {
                print("Common ancestor of \(min) and \(max) is \(currentNode!.value)")
            }
            
        }
        
        findCommonAncestorsFrom(node: rootNodeBST,
                                value1: 0, value2: 9)
        findCommonAncestorsFrom(node: rootNodeBST,
                                value1: 122, value2: 0)
        findCommonAncestorsFrom(node: rootNodeBST,
                                value1: 24, value2: 41)
        findCommonAncestorsFrom(node: rootNodeBST,
                                value1: 8, value2: 9)
        findCommonAncestorsFrom(node: rootNodeBST,
                                value1: 0, value2: 8)
    }
    
    func testIsBinarySearchTree() {
        func checkIfTreeIsBST(rootNode: TreeNode<Int>?) {
            if rootNode == nil {
                print("Not a BST")
            }
            
            if traverseDFS(node: rootNode!,
                           previousElement: &rootNode!.value) {
                print("Not a BST")
            } else {
                print("It is a BST")
            }
        }
        
        func traverseDFS(node: TreeNode<Int>, previousElement: inout Int) -> Bool {
            if node.leftNode != nil {
                return traverseDFS(node: node.leftNode!,
                                   previousElement: &previousElement)
            }
            
            if node.value < previousElement {
                return false
            } else {
                previousElement = node.value
            }
            
            if node.rightNode != nil {
                return traverseDFS(node: node.rightNode!,
                                   previousElement: &previousElement)
            }
            return true
        }
        
        checkIfTreeIsBST(rootNode: rootNodeBST)
        checkIfTreeIsBST(rootNode: rootNodeBinaryTree)
    }
    
    func testHeightOfBinaryTree() {
        func height(node: TreeNode<Int>?) -> Int {            
            if node == nil {
                return 0
                
            } else {
                let leftSubtreeDepth = height(node: node?.leftNode)
                let rightSubtreeDepth = height(node: node?.rightNode)
                
                if leftSubtreeDepth > rightSubtreeDepth {
                    return leftSubtreeDepth + 1
                } else {
                    return rightSubtreeDepth + 1
                }
            }
        }
        
        print("Tree height \(height(node: rootNodeBST))")
    }
    
    func testBinaryTreeHeightWithoutRecursion() {
        
    }
    
    func testBinaryMixHeapFunctionality() {
        let minHeap = BinaryMinHeap(capacity: 15)
        minHeap.insert(value: 2)
        minHeap.insert(value: 234)
        minHeap.insert(value: 12)
        minHeap.insert(value: 43)
        minHeap.insert(value: 65)
        minHeap.insert(value: 87)
        minHeap.insert(value: 345)
        minHeap.insert(value: 65)
        minHeap.insert(value: 87)
        minHeap.insert(value: 91)
        minHeap.insert(value: 653)
        minHeap.insert(value: 87100)
        minHeap.insert(value: 10)
        minHeap.insert(value: 9)
        
        minHeap.traverse()
        
        _ = minHeap.extractMin()
        minHeap.traverse()
        
        _ = minHeap.extractMin()
        minHeap.traverse()
    }
}
