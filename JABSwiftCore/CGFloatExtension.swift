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
}

