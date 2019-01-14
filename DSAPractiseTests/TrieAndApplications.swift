//
//  TrieAndApplications.swift
//  DSAPractiseTests
//
//  Created by Vinayak Parmar on 02/12/18.
//  Copyright © 2018 VMP. All rights reserved.
//

import XCTest

class TrieNode <T: Hashable> {
    var value: T?
    var childrens = [T: TrieNode]()
    var isEndOfWord: Bool = false
    
    init(value: T) {
        self.value = value
    }
    
    init() {
        
    }
    
    func addNode(element: T) -> TrieNode {
        if childrens[element] == nil {
            let newNode = TrieNode.init(value: element)
            childrens[element] = newNode
            return newNode
        } else {
            return childrens[element]!
        }
    }
}

class Trie {
    var head: TrieNode<Character>?
    
    func insert(key: String) {
        if head == nil {
            head = TrieNode()
        }
        
        var temp = head

        for elementIndex in key.indices {
            let char = key[elementIndex]
            
            if temp!.childrens[char] == nil {
                _ = temp?.addNode(element: char)
                temp = temp!.childrens[char]
            } else {
                temp = temp!.childrens[char]
            }
        }
        
        temp?.isEndOfWord = true
    }
    
    func searchFor(key: String) -> Bool {
        guard !key.isEmpty else {
            return false
        }
        
        var temp = head
        
        for elementIndex in key.indices {
            let char = key[elementIndex]
            
            if temp!.childrens[char] == nil {
                return false
            } else {
                temp = temp!.childrens[char]
            }
        }
        
        if temp!.isEndOfWord {
            return true
        } else {
            return false
        }
    }
}

class TrieAndApplications: XCTestCase {
    var trie: Trie?
    
    override func setUp() {
        trie = Trie()
        trie?.insert(key: "hack")
        trie?.insert(key: "hac")
        trie?.insert(key: "vin")
        trie?.insert(key: "vina")
        trie?.insert(key: "r")
        trie?.insert(key: "rose")
        trie?.insert(key: "kenny")
        trie?.insert(key: "kane")
        trie?.insert(key: "ken")
    }
    
    func testSearchingInContactsWithTrie() {
        print(trie?.searchFor(key: "kane"))
        print(trie?.searchFor(key: "kanee"))
        print(trie?.searchFor(key: "vina"))
        print(trie?.searchFor(key: "vin"))
        print(trie?.searchFor(key: "vi"))
        print(trie?.searchFor(key: "hack"))
    }
}
