//
//  CGPointExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/27/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension CGPoint {
    
    public func distanceToPoint(point: CGPoint) -> CGFloat {
        
        let difference = CGPoint(x: x - point.x, y: y - point.y)
        
        return CGFloat(sqrt(Double((difference.x * difference.x) + (difference.y * difference.y))))
        
    }
    
    public func slopeToPoint(point: CGPoint) -> CGFloat? {
        
        let rise = point.y - y
        let run = point.x - x
        
        if run == 0 {
            return nil
        } else {
            return rise/run
        }
        
    }
    
}