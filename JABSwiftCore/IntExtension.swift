//
//  IntExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 1/4/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension Int {
    public func bounded (by lowerBound: Int?, _ upperBound: Int?) -> Int {
        return (self < lowerBound ?? self) ? (lowerBound ?? self) : ((self > upperBound ?? self) ? (upperBound ?? self) : self)
    }
}
