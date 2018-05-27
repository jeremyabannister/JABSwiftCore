//
//  VisualOutlet.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/23/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public protocol VisualOutlet: UniquelyIdentifiableObject {
  func setFrame (_ frame: Rect)
  func setBackgroundColor (_ backgroundColor: Color)
  func setCornerRadius (_ cornerRadius: Double)
  func setShadow (_ shadow: Shadow)
  
  func addSubview (_ view: VisualOutlet?)
  func bringSubview (toFront subview: VisualOutlet?)
  
  var presentedSelf: VisualOutlet { get }
  func value <T> (forKey key: String) -> T?
  func add <PropertyType> (_ animation: SinglePropertyAnimation<PropertyType>, forKey key: String)
  func removeAnimation (forKey key: String)
}
