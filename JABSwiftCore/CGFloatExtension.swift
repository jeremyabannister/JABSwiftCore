//
//  CGFloatExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/13/17.
//  Copyright © 2017 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension CGFloat {
    
    public var degrees: CGFloat { get { return self * (360/(2*CGFloat.pi)) } }
    
    
    public func reduced () -> CGFloat { return atan(tan(self)) + [true: -CGFloat.pi, false: 0][(cos(self) < 0) && (sin(self) < 0)]! + [true: CGFloat.pi, false: 0][(cos(self) < 0) && (sin(self) > 0)]! }
}
