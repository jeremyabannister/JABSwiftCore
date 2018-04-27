//
//  Shadow.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/26/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation

public struct Shadow {
  public let opacity: Float
  public let radius: CGFloat
  public let offset: CGSize
  public let color: UIColor
  
  public init (opacity: Float, radius: CGFloat, offset: CGSize, color: UIColor) {
    self.opacity = opacity
    self.radius = radius
    self.offset = offset
    self.color = color
  }
  public static var none: Shadow { return Shadow(opacity: 0, radius: 0, offset: .zero, color: .black) }
}

extension Shadow: Equatable {
  public static func == (lhs: Shadow, rhs: Shadow) -> Bool {
    return (lhs.opacity == rhs.opacity) && (lhs.radius == rhs.radius) && (lhs.offset == rhs.offset) && (lhs.color == rhs.color)
  }
}
