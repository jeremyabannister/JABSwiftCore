//
//  InterfaceForUIView.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/13/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public protocol InterfaceForUIView: InterfaceElement {
  var interfaceElements: [InterfaceElement?] { get }
  func addUI ()
  func updateUI ()
}

public extension InterfaceForUIView where Self: UIView {
  func addUI () {
    for interfaceElement in interfaceElements {
      if let subview = interfaceElement as? UIView { addSubview(subview) }
      else if let sublayer = interfaceElement as? CALayer { layer.addSublayer(sublayer) }
    }
  }
}
