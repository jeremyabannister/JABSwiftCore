//
//  CALayerExpressible.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/24/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

public protocol CALayerExpressible: VisualOutlet {
  var layer: CALayer { get }
}

extension CALayerExpressible {
  public func setFrame (_ frame: Rect) {
    layer.frame = CGRect(x: frame.x, y: frame.y, width: frame.width, height: frame.height)
  }
  public func setBackgroundColor (_ backgroundColor: Color) {
    layer.backgroundColor = UIColor(red: CGFloat(backgroundColor.red), green: CGFloat(backgroundColor.green), blue: CGFloat(backgroundColor.blue), alpha: CGFloat(backgroundColor.alpha)).cgColor
  }
  public func setOpacity (_ opacity: Double) {
    layer.opacity = Float(opacity)
  }
  public func setCornerRadius (_ cornerRadius: Double) {
    layer.cornerRadius = CGFloat(cornerRadius)
  }
  public func setShadow (_ shadow: Shadow) {
    layer.shadowOpacity = Float(shadow.opacity)
    layer.shadowRadius = CGFloat(shadow.radius)
    layer.shadowOffset = CGSize(width: shadow.offset.width, height: shadow.offset.height)
    layer.shadowColor = UIColor(color: shadow.color).cgColor
  }
}

public extension CALayerExpressible {
  public func setIsUserInteractionEnabled (_ isUserInteractionEnabled: Bool) {
    (self as? UIView)?.isUserInteractionEnabled = isUserInteractionEnabled
  }
  
  public func setClipsToBounds (_ clipsToBounds: Bool) {
    layer.masksToBounds = clipsToBounds
  }
}

public extension CALayerExpressible {
  public func bringSubview (toFront subview: VisualOutlet?) {
    self.addSubview(subview)
  }
  
  public func removeFromSuperview (dummyArgumentToPreventAbortTrap6CompilerError: Bool) {
    (self as? UIView)?.removeFromSuperview()
    (self as? CALayer)?.removeFromSuperlayer()
  }
}

public extension CALayerExpressible {
  public var presentedSelf: VisualOutlet {
    return layer.presentation() ?? layer
  }
  public func value <T> (forKey key: String) -> T? {
    return layer.value(forKey: key) as? T
  }
  public func add <PropertyType> (_ animation: SinglePropertyAnimation<PropertyType>, forKey key: String) {
    layer.add(CABasicAnimation(singlePropertyAnimation: animation), forKey: key)
  }
  public func removeAnimation (forKey key: String) {
    layer.removeAnimation(forKey: key)
  }
}

