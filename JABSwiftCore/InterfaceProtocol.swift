//
//  InterfaceProtocol.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/7/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

public protocol InterfaceProtocol: class {
  var superview: UIView? { get set }
  func setSuperview (_ superview: UIView?)
  
  var interfaceElements: [InterfaceElement] { get }
  func addInterfaceElements ()
  func updateInterfaceElements ()
}
public extension InterfaceProtocol {
  var width: CGFloat { return superview?.width ?? 0 }
  var height: CGFloat { return superview?.height ?? 0 }
  
  func addInterfaceElements () { interfaceElements.forEach({ addInterfaceElement($0) }) }
  func updateInheritedInterface () { }
  func setSuperview (_ superview: UIView?) { self.superview = superview }
  func addInterfaceElement (_ interfaceElement: InterfaceElement) { interfaceElement.addableViews.forEach({ superview?.addSubview($0) }) }
}

