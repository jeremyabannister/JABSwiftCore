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
  public var asRect: Rect { return Rect(x.asDouble, y.asDouble, width.asDouble, height.asDouble) }
}

public extension CABasicAnimation {
  public convenience init <PropertyType> (singlePropertyAnimation: SinglePropertyAnimation<PropertyType>) {
    self.init(keyPath: singlePropertyAnimation.keyPath)
    self.fromValue = singlePropertyAnimation.fromValue
    self.toValue = singlePropertyAnimation.toValue
    self.duration = singlePropertyAnimation.animationParameters.duration
  }
}
