//
//  Size.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/23/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public struct Size {
  public var width: Double
  public var height: Double
  
  public init (width: Double, height: Double) {
    self.width = width
    self.height = height
  }
}

// MARK: - Init
public extension Size {
  public init (_ width: Double, _ height: Double) {
    self.init(width: width, height: height)
  }
}

// MARK: - Static Members
public extension Size {
  public static let zero = Size(0, 0)
}

// MARK: - Hashable
extension Size: Hashable {
  public static func == (lhs: Size, rhs: Size) -> Bool { return lhs.width == rhs.width && lhs.height == rhs.height }
  public var hashValue: Int { return width.hashValue ^ height.hashValue }
}
