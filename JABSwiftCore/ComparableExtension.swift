//
//  ComparableExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 3/26/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension Comparable {
  public func isBetween (_ lowerBound: Self, _ upperBound: Self) -> Bool {
    return (self > lowerBound && self < upperBound) || (self > upperBound && self < lowerBound)
  }
}
