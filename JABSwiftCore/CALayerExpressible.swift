//
//  UIView+VisualOutlet.swift
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

extension UIView: CALayerExpressible { }
extension CALayer: CALayerExpressible {
  public var layer: CALayer { return self }
}
