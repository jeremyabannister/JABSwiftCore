//
//  iOSVisualOutlet.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/20/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

class iOSVisualOutlet: UIView { }

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
