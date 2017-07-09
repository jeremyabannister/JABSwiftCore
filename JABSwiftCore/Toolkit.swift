//
//  Toolkit.swift
//  Swift App
//
//  Created by Jeremy Bannister on 3/26/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit


open class Toolkit {
    
    // MARK:
    // MARK: Strings
    // MARK:
    
    /**
     - returns:
     The string that was passed in with the first letter decapitalized.
     
     - parameters:
        - word: The word to be decapitalized.
     
     
     This function capitalizes the first word of the string which is passed in. Examples:
        * "Hello" -> "hello"
        * "hello" -> "hello"
        * "Hello world" -> "hello world"
        * "!Hello world" -> "!Hello world"
     */
    open static func decapitalizeWord (_ word: String) -> String {
        let head = word.substring(to: word.characters.index(word.startIndex, offsetBy: 1))
        let decapitatedWord = word.substring(from: word.characters.index(word.startIndex, offsetBy: 1))
        return head.lowercased() + decapitatedWord
    }
    
    /**
     - returns:
     The string that was passed in with the first letter capitalized.
     
     - parameters:
     - word: The word to be capitalized.
     
     
     This function capitalizes the first word of the string which is passed in. Examples:
     * "hello" -> "Hello"
     * "Hello" -> "Hello"
     * "hello world" -> "Hello world"
     * "!hello world" -> "!hello world"
     */
    open static func capitalizeWord (_ word: String) -> String {
        let head = word.substring(to: word.characters.index(word.startIndex, offsetBy: 1))
        let decapitatedWord = word.substring(from: word.characters.index(word.startIndex, offsetBy: 1))
        return head.uppercased() + decapitatedWord
    }
    
    
    // MARK:
    // MARK: Arrays
    // MARK:
    
    open static func removeObject<T : Equatable>(_ object: T, fromArray array: inout [T]) {
        var index: Int?
        for i in 0..<array.count {
            if array[i] == object {
                index = i
            }
        }
        
        if index != nil {
            array.remove(at: index!)
        }
    }
    
    open static func indexOfObject<T : Equatable>(_ object: T, inArray array: [T]) -> Int? {
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
    
    open static func rectContainsPoint(_ rect: CGRect, point: CGPoint) -> Bool {
        
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



