//
//  CGRectExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/19/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit

public extension CGRect {
    
  // MARK:
  // MARK: Properties
  // MARK:
  public var x: CGFloat {
    get { return self.origin.x }
    set { self.origin.x = newValue } }
  
  public var y: CGFloat {
    get { return self.origin.y }
    set { self.origin.y = newValue } }
  
  
  
  public var left: CGFloat {
    get { return self.x } }
  
  public var right: CGFloat {
    get { return self.x + size.width } }
  
  public var top: CGFloat {
    get { return self.y } }
  
  public var bottom: CGFloat {
    get { return self.y + size.height } }
  
  
  
  public var zeroedOrigin: CGRect {
    get { return CGRect(origin: .zero, size: size) } }
  
  
  // MARK:
  // MARK: Methods
  // MARK:
  public func containsPoint(_ point: CGPoint) -> Bool {
    if ( point.x < self.x ) { return false }
    if ( point.y < self.y ) { return false }
    if ( point.x > self.right ) { return false }
    if ( point.y > self.bottom ) { return false }
    return true
  }
  
  public func translated (by point: CGPoint) -> CGRect {
    return CGRect(x: self.x + point.x, y: self.y + point.y, width: self.size.width, height: self.size.height)
  }
  
  public static func rect (encompassing rect1: CGRect, and rect2: CGRect) -> CGRect {
    let x = min(of: rect1.x, rect2.x)
    let y = min(of: rect1.y, rect2.y)
    let width = max(of: rect1.right, rect2.right) - x
    let height = max(of: rect1.bottom, rect2.bottom) - y
    return CGRect(x: x, y: y, width: width, height: height)
  }
  
  public func rect (encompassing rect: CGRect) -> CGRect {
    return CGRect.rect(encompassing: self, and: rect)
  }
  
  public static func ~= (_ lhs: CGRect, _ rhs: CGRect) -> Bool {
    let epsilon: CGFloat = 0.001
    if abs(lhs.origin.x - rhs.origin.x) > epsilon { return false }
    if abs(lhs.origin.y - rhs.origin.y) > epsilon { return false }
    if abs(lhs.size.width - rhs.size.width) > epsilon { return false }
    if abs(lhs.size.height - rhs.size.height) > epsilon { return false }
    return true
  }
  
  // ---------------
  // MARK: Print
  // ---------------
  public func print () { Swift.print(self.description) }
}

extension CGRect: CustomStringConvertible {
    public var description: String { return "(\(x), \(y), \(width), \(height))" }
}
