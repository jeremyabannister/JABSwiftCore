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
        let head = word.substringToIndex(advance(word.startIndex, 1))
        let decapitatedWord = word.substringFromIndex(advance(word.startIndex, 1))
        return head.lowercaseString + decapitatedWord
    }
    
    public static func capitalizeWord (word: String) -> String {
        let head = word.substringToIndex(advance(word.startIndex, 1))
        let decapitatedWord = word.substringFromIndex(advance(word.startIndex, 1))
        return head.uppercaseString + decapitatedWord
    }
    
    
    
    // MARK:
    // MARK: Arrays
    // MARK:
    
    public static func removeObject<T : Equatable>(object: T, inout fromArray array: [T]) {
        let index = array.indexOfObject(object)
        array.removeAtIndex(index!)
    }
    
    public static func indexOfObject<T : Equatable>(object: T, inArray array: [T]) -> Int? {
        let index = array.indexOfObject(object)
        return index
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



