//
//  CGRectExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/19/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit



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
    
    
    
    
    
    
    public var left: CGFloat {
        get {
            
            return x
            
        }
    }
    
    
    
    public var right: CGFloat {
        get {
            
            return x + width
            
        }
    }
    
    public var top: CGFloat {
        get {
            
            return y
            
        }
    }
    
    
    
    public var bottom: CGFloat {
        get {
            
            return y + height
            
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
    
    
    
    
    
    
    public func containsPoint(_ point: CGPoint) -> Bool {
        
        if ( point.x < x ) {
            return false
        }
        
        if ( point.y < y ) {
            return false
        }
        
        if ( point.x > right ) {
            return false
        }
        
        if ( point.y > bottom ) {
            return false
        }
        
        return true
        
    }
    
    
    
}
