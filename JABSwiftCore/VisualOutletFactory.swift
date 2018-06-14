//
//  VisualOutletFactory.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/28/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

public class VisualOutletFactory {
  private init () { }
  public static func createNewOutlet () -> VisualOutlet { return UIView() }
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
  public func removeFromSuperview () {
    self.removeFromSuperlayer()
  }
}
