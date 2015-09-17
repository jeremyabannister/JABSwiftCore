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
    
    
    
    
    
    
    
    // Layer
    
    public var opacity: Float {
        get {
            return layer.opacity
        }
        set {
            layer.opacity = newValue
        }
    }
    
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    public var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    public var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(CGColor: color)
            } else {
                print("Problem in JABSwiftCore.UIViewExtension.shadowColor.get - ^^^ shadowColor was not convertible from CGColor to UIColor")
                return UIColor()
            }
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.CGColor
            }
        }
    }
    
    public var shadowPath: CGPath? {
        get {
            return layer.shadowPath
        }
        set {
            layer.shadowPath = newValue
        }
    }
    
    
    
    public func printFrame(tag: NSString = "") {
        if tag == "" {
            print(frame)
        } else {
            print("\(tag) : \(frame)")
        }
    }
    
    
    public func red () {
        backgroundColor = UIColor.redColor()
    }
    
    public func blue () {
        backgroundColor = UIColor.blueColor()
    }
    
    public func green () {
        backgroundColor = UIColor.greenColor()
    }
    
    public func yellow () {
        backgroundColor = UIColor.yellowColor()
    }
    
    public func purple () {
        backgroundColor = UIColor.purpleColor()
    }
    
    public func cyan () {
        backgroundColor = UIColor.cyanColor()
    }
    
    public func white () {
        backgroundColor = UIColor.whiteColor()
    }
    
    public func black () {
        backgroundColor = UIColor.blackColor()
    }
    
    public func lightGray () {
        backgroundColor = UIColor.lightGrayColor()
    }
    
    public func darkGray () {
        backgroundColor = UIColor.darkGrayColor()
    }
    
    
    
    // MARK: Subview Manipulation
    public func changeAllTextOfSubviewsToColor(color: UIColor) {
        
        for subview in subviews {
            if let label = subview as? UILabel {
                label.textColor = color
            } else {
                if subview.subviews.count != 0 {
                    subview.changeAllTextOfSubviewsToColor(color)
                }
            }
        }
        
    }
    
    
}