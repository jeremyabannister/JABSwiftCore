//
//  StringExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 7/12/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension String {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    
    // MARK: Subscript
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
    
    
    // MARK: Is Valid
    public func isValidWholeNumber () -> Bool {
        
        let digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        for i in 0..<count(self) {
            var validCharacter = false
            for digit in digits {
                if self[i] == digits[i] {
                    validCharacter = true
                }
            }
            if !validCharacter {
                return false
            }
        }
        return true
    }
    
}