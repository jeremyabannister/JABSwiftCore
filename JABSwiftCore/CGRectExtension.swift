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