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
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    
    
    // MARK: Is Valid
    public func isValidCombinationOfCharacterSet (_ characterSet: [Character]) -> Bool {
        
        if self.count == 0 {
            return true
        } else {
            for i in 0..<self.count {
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
        if self.count > 0 {
            if self[0] == "-" {
                return String(decapitate()).isValidWholeNumber()
            }
            return isValidWholeNumber()
        } else {
            return true // It is useful to define the empty string to be a valid number
        }
    }
    
    public func isValidFloatingPointNumber () -> Bool {
        
        let split = components(separatedBy: ".")
        
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
        if testSubject.count > 0 {
            if testSubject[0] == "-" {
                testSubject = String(testSubject.decapitate())
            }
        }
        
        if testSubject.count > 0 {
            if testSubject[0] == "$" {
                testSubject = String(testSubject.decapitate())
            } else {
                return false
            }
        } else {
            return false
        }
        
        if testSubject.count > 0 {
            if testSubject[0] == "-" {
                return false
            } else {
                return testSubject.isValidFloatingPointNumber()
            }
        } else {
            return true
        }
        
    }
    
    
    public func isValidVersionNumber () -> Bool {
        
        let components = self.components(separatedBy: ".")
        
        for component in components {
            if !component.isValidWholeNumber() {
                return false
            }
        }
        
        return true
    }
    
    public func isValidEmail () -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    
    
    // MARK: Conversion
    public func doubleFromDollarAmount () -> Double? {
        
        if isValidDollarAmount() {
            var testSubject = self
            var negative = false
            
            if testSubject.count > 0 {
                if testSubject[0] == "-" {
                    negative = true
                    testSubject = String(testSubject.decapitate())
                }
            }
            
            if testSubject.count > 0 {
                if testSubject[0] == "$" {
                    testSubject = String(testSubject.decapitate())
                } else {
                    print("Problem in JABSwiftCore.String.doubleFromDollarAmount - The string \"\(self)\" does not begin with either \"$\" or \"-$\".")
                    return nil
                }
            }
            
            if testSubject.count > 0 {
                if let doubleAmount = testSubject.toDouble() {
                    if negative {
                        return -doubleAmount
                    } else {
                        return doubleAmount
                    }
                } else {
                    return nil
                }
            } else {
                return 0.0
            }
            
        } else {
            print("Problem in JABSwiftCore.String.doubleFromDollarAmount - The string \"\(self)\" is not a valid dollar amount.")
            return nil
        }
    }
    
    public func toDouble () -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    public func toUIColor () -> UIColor {
        return UIColor(self)
    }
    
    public func attributed (with textStyle: TextStyle?) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes: [NSAttributedStringKey.foregroundColor: (textStyle?.textColor ?? .black) as Any, NSAttributedStringKey.font: (textStyle?.font ?? UIFont()) as Any, NSAttributedStringKey.kern: textStyle?.characterSpacing ?? 1])
    }
    
    
    // MARK: Substring
    public func decapitate () -> Substring {
        if self.count > 0 {
            return self[index(after: startIndex)...]
        }
        return ""
    }
    
    
    
    // MARK: Ranges
    public func rangeIsValid (_ nsRange: NSRange) -> Bool {
        if nsRange.location == NSNotFound { return false }
        if nsRange.location + nsRange.length > NSString(string: self).length { return false }
        return true
    }
    
    
}

