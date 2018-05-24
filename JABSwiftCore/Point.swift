//
//  Point.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/23/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public struct Point {
  public var x: Double
  public var y: Double
}

// MARK: - Init
public extension Point {
  public init (_ x: Double, _ y: Double) {
    self.init(x: x, y: y)
  }
}

// MARK: - Static Members
public extension Point {
  public static let zero = Point(0, 0)
}

// MARK: - Hashable
extension Point: Hashable {
  public static func == (lhs: Point, rhs: Point) -> Bool { return lhs.x == rhs.x && lhs.y == rhs.y }
  public var hashValue: Int { return x.hashValue ^ y.hashValue }
}
