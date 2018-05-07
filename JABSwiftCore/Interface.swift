//
//  Interface.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/6/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public protocol Interface: InterfaceElement {
  var interfaceElements: [InterfaceElement?] { get }
  func addUI ()
  func updateUI ()
}

public extension Interface where Self: UIView {
  func addUI () {
    for interfaceElement in interfaceElements {
      if let subview = interfaceElement as? UIView { addSubview(subview) }
      else if let sublayer = interfaceElement as? CALayer { layer.addSublayer(sublayer) }
    }
  }
}
