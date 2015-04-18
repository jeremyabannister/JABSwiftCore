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
        var head = word.substringToIndex(advance(word.startIndex, 1))
        var decapitatedWord = word.substringFromIndex(advance(word.startIndex, 1))
        return head.lowercaseString + decapitatedWord
    }
    
    public static func capitalizeWord (word: String) -> String {
        var head = word.substringToIndex(advance(word.startIndex, 1))
        var decapitatedWord = word.substringFromIndex(advance(word.startIndex, 1))
        return head.uppercaseString + decapitatedWord
    }
    
    
    
    // MARK:
    // MARK: Arrays
    // MARK:
    
    public static func removeObject<T : Equatable>(object: T, inout fromArray array: [T])
    {
        var index = find(array, object)
        array.removeAtIndex(index!)
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




public extension UIView {
    
    public var x: CGFloat {
        get {
            
            return frame.origin.x
            
        }
        set(newX) {
            
            var newFrame = frame
            newFrame.origin.x = newX
            frame = newFrame
            
        }
    }
    
    public var y: CGFloat {
        get {
            
            return frame.origin.y
            
        }
        set(newY) {
            
            var newFrame = frame
            newFrame.origin.y = newY
            frame = newFrame
            
        }
    }
    
    public var width: CGFloat {
        get {
            
            return frame.size.width
            
        }
        set(newWidth) {
            
            var newFrame = frame
            newFrame.size.width = newWidth
            frame = newFrame
            
        }
    }
    
    public var height: CGFloat {
        get {
            
            return frame.size.height
            
        }
        set(newHeight) {
            
            var newFrame = frame
            newFrame.size.height = newHeight
            frame = newFrame
            
        }
    }
    
    
    
    
    
    public var left: CGFloat {
        get {
            
            return frame.origin.x
            
        }
        set(newLeft) {
            
            var newFrame = frame
            newFrame.origin.x = newLeft
            frame = newFrame
            
        }
    }
    
    
    
    public var right: CGFloat {
        get {
            
            return frame.origin.x + frame.size.width
            
        }
        set(newRight) {
            
            // MARK: Unfinished
            
        }
    }
    
    public var top: CGFloat {
        get {
            
            return frame.origin.y
            
        }
        set(newTop) {
            
            var newFrame = frame
            newFrame.origin.y = newTop
            frame = newFrame
            
        }
    }
    
    
    
    public var bottom: CGFloat {
        get {
            
            return frame.origin.y + frame.size.height
            
        }
        set(newBottom) {
            
            // MARK: Unfinished
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    public var relativeFrame: CGRect {
        get {
            
            var computedFrame = frame
            computedFrame.origin.x = 0
            computedFrame.origin.y = 0
            return computedFrame
            
        }
        set(newRelativeFrame) {
            
            var newFrame = frame
            newFrame.size.width = newRelativeFrame.size.width
            newFrame.size.height = newRelativeFrame.size.height
            frame = newFrame
            
        }
    }
}





public extension CGRect {
    
    public var x: CGFloat {
        get {
            
            return origin.x
            
        }
        set(newX) {
            
            var newOrigin = origin
            newOrigin.x = newX
            origin = newOrigin
            
        }
    }
    
    public var y: CGFloat {
        get {
            
            return origin.y
            
        }
        set(newY) {
            
            var newOrigin = origin
            newOrigin.y = newY
            origin = newOrigin
            
        }
    }
    
    public var width: CGFloat {
        get {
            
            return size.width
            
        }
        set(newWidth) {
            
            var newSize = size
            newSize.width = newWidth
            size = newSize
            
        }
    }
    
    public var height: CGFloat {
        get {
            
            return size.height
            
        }
        set(newHeight) {
            
            var newSize = size
            newSize.height = newHeight
            size = newSize
            
        }
    }
    
    
    
    
    
    
    
    
    
    public var relativeFrame: CGRect {
        get {
            
            var computedFrame = self
            computedFrame.origin.x = 0
            computedFrame.origin.y = 0
            return computedFrame
            
        }
        set(newRelativeFrame) {
            
            var newSize = newRelativeFrame.size
            newSize.width = newRelativeFrame.size.width
            newSize.height = newRelativeFrame.size.height
            size = newSize
            
        }
    }
    
}



