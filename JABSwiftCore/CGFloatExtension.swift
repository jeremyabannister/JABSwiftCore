//
//  CGFloatExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/13/17.
//  Copyright © 2017 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension CGFloat {
    
    public var degrees: CGFloat { get { return self * (180/(.pi)) } }
    public var radians: CGFloat { get { return self * (.pi/180) } }
    public var reducedAngle: CGFloat { var angle = self; while angle >= (2 * .pi) { angle -= (2 * .pi) }; while angle < 0 { angle += (2 * .pi) }; return angle }
    
    
    public static func ~= (_ lhs: CGFloat, _ rhs: CGFloat) -> Bool {
        let epsilon: CGFloat = 0.001
        if abs(lhs - rhs) > epsilon { return false }
        return true
    }
    
    public func bounded (by lowerBound: CGFloat?, _ upperBound: CGFloat?) -> CGFloat {
        return (self < lowerBound ?? self) ? (lowerBound ?? self) : ((self > upperBound ?? self) ? (upperBound ?? self) : self)
    }
}
