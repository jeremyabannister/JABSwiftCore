//
//  UIColorExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/19/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
  
  public convenience init (hex: String) {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }
    if ((cString.count) != 6) { self.init(white: (128.0/255.0), alpha: 1); return }
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
  }
  
  public func dim (_ fraction: CGFloat) -> UIColor {
    
    // Force the fraction to be between 0 and 1
    let modifiedFraction = fraction.bounded(by: 0, 1)
    
    let redComponent = components.red
    let greenComponent = components.green
    let blueComponent = components.blue
    let alpha = components.alpha
    
    if alpha == 0 { return UIColor(red: redComponent, green: greenComponent, blue: blueComponent, alpha: (1 - modifiedFraction)) }
    return UIColor(red: redComponent * modifiedFraction, green: greenComponent * modifiedFraction, blue: blueComponent * modifiedFraction, alpha: alpha)
  }
  
  public var components:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    var r:CGFloat = 0
    var g:CGFloat = 0
    var b:CGFloat = 0
    var a:CGFloat = 0
    getRed(&r, green: &g, blue: &b, alpha: &a)
    return (r,g,b,a)
  }
  
  public func withRed (_ red: CGFloat) -> UIColor {
    return UIColor(red: red, green: components.green, blue: components.blue, alpha: components.alpha)
  }
  
  public func withGreen (_ green: CGFloat) -> UIColor {
    return UIColor(red: components.red, green: green, blue: components.blue, alpha: components.alpha)
  }
  
  public func withBlue (_ blue: CGFloat) -> UIColor {
    return UIColor(red: components.red, green: components.green, blue: blue, alpha: components.alpha)
  }
  
  public func withAlpha (_ alpha: CGFloat) -> UIColor {
    return UIColor(red: components.red, green: components.green, blue: components.blue, alpha: alpha)
  }
}

