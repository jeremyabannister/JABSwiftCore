//
//  CGPointExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/27/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension CGPoint {
    
    public func distanceToPoint(_ point: CGPoint) -> CGFloat {
        
        let difference = CGPoint(x: x - point.x, y: y - point.y)
        
        return CGFloat(sqrt(Double((difference.x * difference.x) + (difference.y * difference.y))))
        
    }
    
    public func slopeToPoint(_ point: CGPoint) -> CGFloat? {
        
        let rise = point.y - y
        let run = point.x - x
        
        if run == 0 {
            return nil
        } else {
            return rise/run
        }
        
    }
}



// Basic
public func + (left: CGPoint, right: CGPoint) -> CGPoint { return CGPoint(x: left.x + right.x, y: left.y + right.y) }
public func - (left: CGPoint, right: CGPoint) -> CGPoint { return CGPoint(x: left.x - right.x, y: left.y - right.y) }
public func * (left: CGPoint, right: CGFloat) -> CGPoint { return CGPoint(x: left.x * right, y: left.y * right) }
public func * (left: CGFloat, right: CGPoint) -> CGPoint { return right * left }
public func * (left: (CGPoint, CGPoint), right: CGFloat) -> (CGPoint, CGPoint) { return (left.0 * right, left.1 * right) }


// Dot Product
infix operator •
public func • (left: CGPoint, right: CGPoint) -> CGFloat { return (left.x * right.x) + (left.y * right.y) }

// Cross Product // Only return the z value of the cross product since x and y values are 0
infix operator ***
public func *** (left: CGPoint, right: CGPoint) -> CGFloat { return (left.x * right.y) - (left.y * right.x) }

// Vector Rotation
infix operator &<
infix operator &>
public func &< (left: CGPoint, right: CGFloat) -> CGPoint { return CGPoint(x: (left.x * cos(right)) + (left.y * sin(right)), y: (left.x * sin(-right)) + (left.y * cos(right))) }
public func &> (left: CGPoint, right: CGFloat) -> CGPoint { return left &< -right  }


