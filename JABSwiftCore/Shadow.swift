//
//  Shadow.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/26/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public struct Shadow {
  public let opacity: Double
  public let radius: Double
  public let offset: Size
  public let color: Color
  
  public init (opacity: Double, radius: Double, offset: Size, color: Color) {
    self.opacity = opacity
    self.radius = radius
    self.offset = offset
    self.color = color
  }
}

// MARK: - Static Members
public extension Shadow {
  public static var none: Shadow { return Shadow(opacity: 0, radius: 0, offset: .zero, color: .black) }
}

// MARK: - Hashable
extension Shadow: Hashable {
  public static func == (lhs: Shadow, rhs: Shadow) -> Bool {
    return (lhs.opacity == rhs.opacity) && (lhs.radius == rhs.radius) && (lhs.offset == rhs.offset) && (lhs.color == rhs.color)
  }
  public var hashValue: Int { return opacity.hashValue ^ radius.hashValue ^ offset.hashValue ^ color.hashValue }
}
