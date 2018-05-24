//
//  Rect.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/23/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public struct Rect {
  public var origin: Point
  public var size: Size
}

// MARK: - Init
public extension Rect {
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
public extension Rect {
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
}

// MARK: - Static Members
public extension Rect {
  public static let zero = Rect(0, 0, 0, 0)
}

// MARK: - Hashable
extension Rect: Hashable {
  public static func == (lhs: Rect, rhs: Rect) -> Bool { return lhs.origin == rhs.origin && lhs.size == rhs.size }
  public var hashValue: Int { return origin.hashValue ^ size.hashValue }
}
