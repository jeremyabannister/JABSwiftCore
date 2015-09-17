//
//  Toolkit.swift
//  Swift App
//
//  Created by Jeremy Bannister on 3/26/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit



public class Toolkit {
    
    // MARK:
    // MARK: Strings
    // MARK:
    public static func decapitalizeWord (word: String) -> String {
        let head = word.substringToIndex(word.startIndex.advancedBy(1))
        let decapitatedWord = word.substringFromIndex(word.startIndex.advancedBy(1))
        return head.lowercaseString + decapitatedWord
    }
    
    public static func capitalizeWord (word: String) -> String {
        let head = word.substringToIndex(word.startIndex.advancedBy(1))
        let decapitatedWord = word.substringFromIndex(word.startIndex.advancedBy(1))
        return head.uppercaseString + decapitatedWord
    }
    
    public static func intendedStringFromIngredients (initialString: String, range: NSRange, replacementString: String) -> String {
        
        var frankensteinString = initialString.substringToIndex(initialString.startIndex.advancedBy(range.location))
        frankensteinString += replacementString
        frankensteinString += initialString.substringFromIndex(initialString.startIndex.advancedBy(range.location + range.length))
        
        return frankensteinString
    }
    
    
    // MARK:
    // MARK: Arrays
    // MARK:
    
    public static func removeObject<T : Equatable>(object: T, inout fromArray array: [T]) {
        var index: Int?
        for i in 0..<array.count {
            if array[i] == object {
                index = i
            }
        }
        
        if index != nil {
            array.removeAtIndex(index!)
        }
    }
    
    public static func indexOfObject<T : Equatable>(object: T, inArray array: [T]) -> Int? {
        for i in 0..<array.count {
            if array[i] == object {
                return i
            }
        }
        
        return nil
    }
    
    
    
    // MARK:
    // MARK: Rects
    // MARK:
    
    public static func rectContainsPoint(rect: CGRect, point: CGPoint) -> Bool {
        
        let xTest = point.x - rect.x
        let yTest = point.y - rect.y
        
        if (xTest < rect.width) && (point.x > rect.x) {
            
            if (yTest < rect.height) && (point.y > rect.y) {
                
                return true
                
            }
            
        }
        
        return false
    }
    
    
}



