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

// MARK: - Dim
public extension Color {
  public func dimmed (to fraction: Double) -> Color {
    let modifiedFraction = fraction.bounded(by: 0, 1)
    
    if alpha == 0 { return Color(red: red, green: green, blue: blue, alpha: (1 - modifiedFraction)) }
    return Color(red: red * modifiedFraction, green: green * modifiedFraction, blue: blue * modifiedFraction, alpha: alpha)
  }
}

// MARK: - Chainable Setters
public extension Color {
  func withRed (_ newValue: Double) -> Color {
    var copy = self
    copy.red = newValue
    return copy
  }
  
  func withGreen (_ newValue: Double) -> Color {
    var copy = self
    copy.green = newValue
    return copy
  }
  
  func withBlue (_ newValue: Double) -> Color {
    var copy = self
    copy.blue = newValue
    return copy
  }
  
  func withAlpha (_ newValue: Double) -> Color {
    var copy = self
    copy.alpha = newValue
    return copy
  }
}

// MARK: - Hashable
extension Color: Hashable {
  public static func == (lhs: Color, rhs: Color) -> Bool {
    return lhs.red == rhs.red && lhs.green == rhs.green && rhs.blue == lhs.blue && rhs.alpha == lhs.alpha
  }
  public var hashValue: Int { return red.hashValue ^ green.hashValue ^ blue.hashValue ^ alpha.hashValue }
}
