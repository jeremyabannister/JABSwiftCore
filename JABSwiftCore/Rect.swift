//
//  Rect.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/23/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

// MARK: - Initial Declaration
public struct Rect {
  public var origin: Point
  public var size: Size
}

// MARK: - Static Members
extension Rect {
  public static let zero = Rect(0, 0, 0, 0)
}

// MARK: - Init
extension Rect {
  public init () {
    self.init(0, 0, 0, 0)
  }
  
  public init (_ x: Double, _ y: Double, _ width: Double, _ height: Double) {
    self.init(x: x, y: y, width: width, height: height)
  }
  
  public init (x: Double, y: Double, width: Double, height: Double) {
    self.init(origin: Point(x, y), size: Size(width, height))
  }
}

// MARK: - Computed Properties
extension Rect {
  public var x: Double {
    get { return origin.x }
    set { origin.x = newValue }
  }
  public var y: Double {
    get { return origin.y }
    set { origin.y = newValue }
  }
  public var width: Double {
    get { return size.width }
    set { size.width = newValue }
  }
  public var height: Double {
    get { return size.height }
    set { size.height = newValue }
  }
  
  public var left: Double { return x }
  public var right: Double { return x + width }
  public var top: Double { return y }
  public var bottom: Double { return y + height }
  
  public func contains (_ point: Point) -> Bool {
    return point.x.isBetween(left, right) && point.y.isBetween(top, bottom)
  }
}

// MARK: - Chainable Setters
extension Rect {
  public func withOrigin (_ newValue: Point) -> Rect {
    var copy = self
    copy.origin = newValue
    return copy
  }
  public func withSize (_ newValue: Size) -> Rect {
    var copy = self
    copy.size = newValue
    return copy
  }
  public func withX (_ newValue: Double) -> Rect {
    var copy = self
    copy.x = newValue
    return copy
  }
  public func withY (_ newValue: Double) -> Rect {
    var copy = self
    copy.y = newValue
    return copy
  }
  public func withWidth (_ newValue: Double) -> Rect {
    var copy = self
    copy.width = newValue
    return copy
  }
  public func withHeight (_ newValue: Double) -> Rect {
    var copy = self
    copy.height = newValue
    return copy
  }
}

// MARK: - Chainable Optional Setters
extension Rect {
  public func withOrigin (_ newValue: Point?) -> Rect? {
    guard let newValue = newValue else { return nil }
    return self.withOrigin(newValue)
  }
  public func withSize (_ newValue: Size?) -> Rect? {
    guard let newValue = newValue else { return nil }
    return self.withSize(newValue)
  }
  public func withX (_ newValue: Double?) -> Rect? {
    guard let newValue = newValue else { return nil }
    return self.withX(newValue)
  }
  public func withY (_ newValue: Double?) -> Rect? {
    guard let newValue = newValue else { return nil }
    return self.withY(newValue)
  }
  public func withWidth (_ newValue: Double?) -> Rect? {
    guard let newValue = newValue else { return nil }
    return self.withWidth(newValue)
  }
  public func withHeight (_ newValue: Double?) -> Rect? {
    guard let newValue = newValue else { return nil }
    return self.withHeight(newValue)
  }
}

// MARK: - Hashable
extension Rect: Hashable {
  public static func == (lhs: Rect, rhs: Rect) -> Bool { return lhs.origin == rhs.origin && lhs.size == rhs.size }
  public var hashValue: Int { return origin.hashValue ^ size.hashValue }
}
