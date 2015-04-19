//
//  UIViewExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/19/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit


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
    
    
    
    
    
    
    
    public var opacity: Float {
        get {
            return layer.opacity
        }
        set {
            layer.opacity = newValue
        }
    }
    
    
}