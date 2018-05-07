//
//  Deprecated.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/6/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation


import UIKit

public protocol InterfaceSet {
  var elements: [InterfaceElementOld] { get }
}
public protocol InterfaceElementOld {
  var addableViews: [UIView] { get }
}




public protocol InterfaceProtocol: class {
  var superview: UIView? { get set }
  func setSuperview (_ superview: UIView?)
  
  var interfaceElements: [InterfaceElementOld] { get }
  func addInterfaceElements ()
  func updateInterfaceElements ()
}
public extension InterfaceProtocol {
  var width: CGFloat { return superview?.width ?? 0 }
  var height: CGFloat { return superview?.height ?? 0 }
  
  func addInterfaceElements () { interfaceElements.forEach({ addInterfaceElement($0) }) }
  func updateInheritedInterface () { }
  func setSuperview (_ superview: UIView?) { self.superview = superview }
  func addInterfaceElement (_ interfaceElement: InterfaceElementOld) { interfaceElement.addableViews.forEach({ superview?.addSubview($0) }) }
}






public protocol InterfaceNode {
  var interfaces: [InterfaceProtocol] { get }
}
public extension InterfaceNode {
  func addUI () { interfaces.forEach({ $0.addInterfaceElements() }) }
  func updateUI () { interfaces.forEach({ $0.updateInterfaceElements() }) }
}
