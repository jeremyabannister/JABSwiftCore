//
//  iOSSpecificConversions.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/26/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

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
  public var asColor: Color { return Color(components.red.asDouble, components.green.asDouble, components.blue.asDouble, components.alpha.asDouble) }
}

public extension CABasicAnimation {
  public convenience init <PropertyType> (singlePropertyAnimation: SinglePropertyAnimation<PropertyType>) {
    self.init(keyPath: singlePropertyAnimation.keyPath)
    self.fromValue = singlePropertyAnimation.fromValue
    self.toValue = singlePropertyAnimation.toValue
    self.duration = singlePropertyAnimation.animationParameters.duration
  }
}
