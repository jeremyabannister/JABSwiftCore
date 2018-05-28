//
//  Color.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/23/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public struct Color {
  public var red: Double
  public var green: Double
  public var blue: Double
  public var alpha: Double
}

// MARK: - Init
public extension Color {
  public init (_ red: Double, _ green: Double, _ blue: Double, _ alpha: Double) {
    self.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
  }
}

// MARK: - Static Members
public extension Color {
  public static let red = Color(255, 0, 0, 1)
  public static let green = Color(0, 255, 0, 1)
  public static let blue = Color(0, 0, 255, 1)
  public static let clear = Color(0, 0, 0, 0)
  public static let white = Color(255, 255, 255, 1)
  public static let black = Color(0, 0, 0, 1)
}

// MARK: - Hashable
extension Color: Hashable {
  public static func == (lhs: Color, rhs: Color) -> Bool {
    return lhs.red == rhs.red && lhs.green == rhs.green && rhs.blue == lhs.blue && rhs.alpha == lhs.alpha
  }
  public var hashValue: Int { return red.hashValue ^ green.hashValue ^ blue.hashValue ^ alpha.hashValue }
}
