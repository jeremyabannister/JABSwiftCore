//
//  iOSSpecificConversions.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/26/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

public extension CGFloat {
  public init? (_ value: Double?) {
    guard let value = value else { return nil }
    self.init(value)
  }
}

public extension CGPoint {
  public init (_ point: Point) {
    self.init(x: point.x, y: point.y)
  }
  public var asPoint: Point { return Point(x.asDouble, y.asDouble) }
}

public extension CGSize {
  public init (_ size: Size) {
    self.init(width: CGFloat(size.width), height: CGFloat(size.height))
  }
  public var asSize: Size { return Size(width: width.asDouble, height: height.asDouble) }
}

public extension CGRect {
  public init (_ rect: Rect) {
    self.init(x: CGFloat(rect.x), y: CGFloat(rect.y), width: CGFloat(rect.width), height: CGFloat(rect.height))
  }
  public var asRect: Rect { return Rect(x.asDouble, y.asDouble, width.asDouble, height.asDouble) }
}

public extension UIColor {
  public convenience init (_ color: Color) {
    self.init(red: CGFloat(color.red), green: CGFloat(color.green), blue: CGFloat(color.blue), alpha: CGFloat(color.alpha))
  }
  public var asColor: Color { return Color(red: components.red.asDouble, green: components.green.asDouble, blue: components.blue.asDouble, alpha: components.alpha.asDouble) }
}

public extension UIFont {
  public convenience init? (_ font: Font?) {
    guard let font = font else { return nil }
    self.init(name: font.fontNameString, size: CGFloat(font.size))
  }
  public var asFont: Font {
    return Font(size: pointSize.asDouble, family: .other(fontName), weight: .normal)
  }
}

public extension CABasicAnimation {
  public convenience init <PropertyType> (singlePropertyAnimation: SinglePropertyAnimation<PropertyType>) {
    self.init(keyPath: singlePropertyAnimation.keyPath)
    self.fromValue = singlePropertyAnimation.fromValue
    self.toValue = singlePropertyAnimation.toValue
    self.duration = singlePropertyAnimation.animationParameters.duration
  }
}

public extension NSTextAlignment {
  public init (_ textAlignment: TextAlignment) {
    switch textAlignment {
      case .left: self = .left
      case .right: self = .right
      case .center: self = .center
      case .justified: self = .justified
    }
  }
  public var asTextAlignment: TextAlignment {
    switch self {
      case .left: return .left
      case .right: return .right
      case .center: return .center
      case .justified: return .justified
      default: return .left
    }
  }
}
