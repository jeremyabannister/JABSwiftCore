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

// MARK: - Operators
public extension Point {
  static func + (lhs: Point, rhs: Point) -> Point { return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y) }
  static func - (lhs: Point, rhs: Point) -> Point { return Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y) }
  static func * (lhs: Point, rhs: Double) -> Point { return Point(x: lhs.x * rhs, y: lhs.y * rhs) }
  static func * (lhs: Double, rhs: Point) -> Point { return Point(x: lhs * rhs.x, y: lhs * rhs.y) }
  static func * (lhs: Point, rhs: Int) -> Point { return lhs * Double(rhs) }
  static func * (lhs: Int, rhs: Point) -> Point { return Double(lhs) * rhs }
  static func / (lhs: Point, rhs: Double) -> Point {
    guard rhs != 0 else { return .zero }
    return Point(x: lhs.x / rhs, y: lhs.y / rhs)
  }
  static func / (lhs: Point, rhs: Int) -> Point { return lhs / Double(rhs) }
}

// MARK: - Array
public extension Array where Element == Point {
  public var sum: Point { return self.reduce(.zero, +) }
  public var average: Point { return sum/self.count }
}
