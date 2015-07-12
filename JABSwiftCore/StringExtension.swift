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
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
    
    
    // MARK: Is Valid
    public func isValidCombinationOfCharacterSet (characterSet: [Character]) -> Bool {
        
        if count(self) == 0 {
            return true
        } else {
            for i in 0..<count(self) {
                var validCharacter = false
                for character in characterSet {
                    if self[i] == character {
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
    
    public func isValidWholeNumber () -> Bool {
        
        return self.isValidCombinationOfCharacterSet(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])
    }
    
    public func isValidInteger () -> Bool {
        if count(self) > 0 {
            if self[0] == "-" {
                return decapitate().isValidWholeNumber()
            }
            return isValidWholeNumber()
        } else {
            return true // It is useful to define the empty string to be a valid number
        }
    }
    
    public func isValidFloatingPointNumber () -> Bool {
        
        let split = componentsSeparatedByString(".")
        
        switch split.count {
        case 0:
            return true
        case 1:
            return split[0].isValidInteger()
        case 2:
            return split[0].isValidInteger() && split[1].isValidWholeNumber()
        default:
            return false
        }
    }
    
    public func isValidDollarAmount () -> Bool {
        
        var testSubject = self
        if count(testSubject) > 0 {
            if testSubject[0] == "-" {
                testSubject = testSubject.decapitate()
            }
        }
        
        if count(testSubject) > 0 {
            if testSubject[0] == "$" {
                testSubject = testSubject.decapitate()
            } else {
                return false
            }
        } else {
            return false
        }
        
        if count(testSubject) > 0 {
            if testSubject[0] == "-" {
                return false
            } else {
                return testSubject.isValidFloatingPointNumber()
            }
        } else {
            return true
        }
        
    }
    
    
    
    // MARK: Conversion
    
    
    public func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
    
    
    
    // MARK: Substring
    public func decapitate () -> String {
        if count(self) > 0 {
            return substringFromIndex(advance(startIndex, 1))
        }
        return ""
    }
    
    
}