//
//  TestHelpers.swift
//  DSAPractiseTests
//
//  Created by Vinayak Parmar on 06/09/18.
//  Copyright © 2018 VMP. All rights reserved.
//

import Foundation

extension Character {
    func isOperator() -> Bool {
        let operators = "*+/-"
        
        return operators.contains(self)
    }
    
    func isBracket() -> Bool {
        let operators = "()"
        
        return operators.contains(self)
    }
    
    func isLetterOrDigit() -> Bool {
        let operators = "012345678910abcdefghijklABCDEFGHIJKL"
        
        return operators.contains(self)
    }
    
    var precedence : Int {
        switch self {
        case "*", "/":
            return 2
            
        case "+", "-":
            return 1
            
        default:
            return 1
        }
    }
}

protocol Initable {
    init()
}

extension String: Initable {}
extension Int: Initable {}

