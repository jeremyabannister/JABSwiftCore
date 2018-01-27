//
//  IntExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 1/4/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension Int {
  public var absoluteValue: Int { return abs(self) }
  
  public func bounded (by lowerBound: Int?, _ upperBound: Int?) -> Int {
    return (self < lowerBound ?? self) ? (lowerBound ?? self) : ((self > upperBound ?? self) ? (upperBound ?? self) : self)
  }
  
  public func cycled (toWithin bound1: Int, _ bound2: Int) -> Int {
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
}
