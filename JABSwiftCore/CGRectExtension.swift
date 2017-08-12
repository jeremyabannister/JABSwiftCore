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
    
    // MARK:
    // MARK: Properties
    // MARK:
    public var x: CGFloat {
        get { return self.origin.x }
        set { self.origin.x = newValue } }
    
    public var y: CGFloat {
        get { return self.origin.y }
        set { self.origin.y = newValue } }
    
    
    
    public var left: CGFloat {
        get { return self.x } }
    
    public var right: CGFloat {
        get { return self.x + size.width } }
    
    public var top: CGFloat {
        get { return self.y } }
    
    public var bottom: CGFloat {
        get { return self.y + size.height } }
    
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    public func containsPoint(_ point: CGPoint) -> Bool {
        if ( point.x < self.x ) { return false }
        if ( point.y < self.y ) { return false }
        if ( point.x > self.right ) { return false }
        if ( point.y > self.bottom ) { return false }
        return true
    }
    
    public func translated (by point: CGPoint) -> CGRect {
        return CGRect(x: self.x + point.x, y: self.y + point.y, width: self.size.width, height: self.size.height)
    }
}
