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
  public func bringSubview (toFront subview: VisualOutlet?) {
    self.addSubview(subview)
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





extension UIView: CALayerExpressible {
  public func addSubview (_ view: VisualOutlet?) {
    if let view = view as? UIView { addSubview(view) } // Since view is now a UIView, the proper addSubview(_:) will be called
    if let layer = view as? CALayer { layer.addSublayer(layer) }
  }
}
extension CALayer: CALayerExpressible {
  public var layer: CALayer { return self }
  public func addSubview (_ view: VisualOutlet?) {
    guard let layer = (view as? CALayerExpressible)?.layer else { return }
    layer.addSublayer(layer)
  }
}
