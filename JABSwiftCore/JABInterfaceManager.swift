//
//  JABInterfaceManager.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/7/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

public protocol JABInterfaceManager {
  var superview: UIView? { get set }
  mutating func setSuperview (_ superview: UIView?)
  
  var interfaceSet: JABInterfaceSet { get }
  func addInterfaceSet ()
  func updateInterfaceSet ()
}
public extension JABInterfaceManager {
  var width: CGFloat { return superview?.width ?? 0 }
  var height: CGFloat { return superview?.height ?? 0 }
  
  func addInterfaceSet () { interfaceSet.elements.forEach({ addInterfaceElement($0) }) }
  func updateInheritableInterface () { }
  mutating func setSuperview (_ superview: UIView?) { self.superview = superview }
  func addInterfaceElement (_ interfaceElement: InterfaceElement) { interfaceElement.addableViews.forEach({ superview?.addSubview($0) }) }
}

