//
//  FloatingPointExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 1/26/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension FloatingPoint {
  public var radians: Self { return self * (.pi/180) }
  public var degrees: Self { return self * (180/(.pi)) }
  public var reducedRadians: Self { return self.cycled(toWithin: 0, 2 * .pi) }
  public var reducedDegrees: Self { return self.cycled(toWithin: 0, 360) }
  public var absoluteValue: Self { return abs(self) }
  public func bounded (by lowerBound: Self?, _ upperBound: Self?) -> Self {
    return (self < lowerBound ?? self) ? (lowerBound ?? self) : ((self > upperBound ?? self) ? (upperBound ?? self) : self)
  }
  public static func ~= (_ lhs: Self, _ rhs: Self) -> Bool { return abs(lhs - rhs).asDouble < 0.001 }
  public var asCGFloat: CGFloat { return (self as? CGFloat) ?? CGFloat((self as? Double) ?? 0) }
  public var asDouble: Double { return (self as? Double) ?? Double((self as? CGFloat) ?? 0) }
  public func cycled (toWithin bound1: Self, _ bound2: Self) -> Self {
    if bound1 == bound2 { return bound1 }
    let lowerBound = bound1 < bound2 ? bound1 : bound2
    let upperBound = bound2 > bound1 ? bound2 : bound1
    let cycleLength = upperBound - lowerBound
    var cycledSelf = self
    while !(cycledSelf >= lowerBound && cycledSelf < upperBound) {
      if cycledSelf < lowerBound { cycledSelf += cycleLength }
      if cycledSelf >= upperBound { cycledSelf -= cycleLength }
    }
    return cycledSelf
  }
  public func flooredToDecimalPlaces (_ numberOfDecimalPlaces: Int) -> Self {
    return floor(self.asDouble * pow(10, Double(numberOfDecimalPlaces)))/pow(10, Double(numberOfDecimalPlaces)) as? Self ?? 0
  }
  
  
  // ---------------
  // MARK: Print
  // ---------------
  public func print () { Swift.print(self) }
}
