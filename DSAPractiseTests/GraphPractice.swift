//
//  GraphPractice.swift
//  DSAPractiseTests
//
//  Created by Vinayak Parmar on 28/11/18.
//  Copyright © 2018 VMP. All rights reserved.
//

import XCTest

class GraphPractice: XCTestCase {

    var graph: Graph!
    let vertices = 4
    let edges = 6
    
    override func setUp() {
        graph = Graph(vertices: vertices,
                      edgesCount: edges)
        
        graph.addEdgeFrom(source: 0, destination: 2)
        graph.addEdgeFrom(source: 0, destination: 1)
        graph.addEdgeFrom(source: 2, destination: 0)
        graph.addEdgeFrom(source: 2, destination: 3)
        graph.addEdgeFrom(source: 3, destination: 3)
        graph.addEdgeFrom(source: 1, destination: 2)
    }
    
    func testPrintGraphBFS() {
        graph.printGraphBFS()
    }
    
    func testPrintGraphDFS() {
        graph.printGraphDFS()
    }
    
    /// Minimimum spanning tree problems
    func testPrimsAlgo() {
        
    }
    
    func testKrushkalsAlgo() {
        
    }
    
    /// Shortest path algos
    func testDijkstra() {
        
    }
    
    func testBellmanFordAlgo() {
        
    }
}

struct Graph {
    private let vertices: Int
    private let edgesCount: Int
    private var adjacencyMatix: [[Int]] 
    
    init(vertices: Int,
         edgesCount: Int) {
        self.vertices = vertices
        self.edgesCount = edgesCount
        
        adjacencyMatix = Array.init(repeating: Array.init(repeating: 0,
                                                          count: self.vertices),
                                    count: self.vertices)
    }
    
    mutating func addEdgeFrom(source: Int,
                              destination: Int) {
        if source < vertices && destination < vertices  {
            adjacencyMatix[source][destination] = 1
        } else {
            print("Trying to enter invalid edge")
        }
    }
    
    func printGraphDFS() {
        var visited = Array(repeating: false, count: vertices)
        
        func traverseDFSFrom(sourceElement: Int) {
            visited[sourceElement] = true
            print(sourceElement, terminator: ",")
            
            for endElement in 0..<vertices {
                if adjacencyMatix[sourceElement][endElement] == 1 && !visited[endElement] {
                    traverseDFSFrom(sourceElement: endElement)
                }
            }
        }

        for index in 0..<vertices {
            if !visited[index] {
                traverseDFSFrom(sourceElement: index)
                print("")
            }
        }
    }
    
    func printGraphBFS() {
        func traverseBFSFrom(sourceElement: Int) {
            var visited = Array(repeating: false,
                                count: vertices)
            let visitedNodesQueue = Queue<Int>(capacity: vertices)
            visited[sourceElement] = true
            visitedNodesQueue.enqueue(element: sourceElement)
            
            while visitedNodesQueue.size != 0 {
                let newElement = visitedNodesQueue.dequeue()!
                print(newElement, terminator: ",")
                
                for endElement in 0..<vertices {
                    if adjacencyMatix[newElement][endElement] == 1 && !visited[endElement] {
                        visitedNodesQueue.enqueue(element: endElement)
                        visited[endElement] = true
                    }
                }
            }
        }
        
        for index in 0..<vertices {
            traverseBFSFrom(sourceElement: index)
            print("")
        }
    }
}
