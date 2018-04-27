//
//  UIViewExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/19/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  
  /// This is just the frame, but by using a different name I can monitor all frame changes within my app which is essential to my custom animation system
  @objc open var site: CGRect {
    get { return frame }
    set {
      if site ~= newValue { return }
      // Turns out the bounds origin is not always (0, 0), for example in the case of a scrolled UITableView
      let newBounds = CGRect(origin: layer.bounds.origin, size: newValue.size)
      let newPosition = newValue.origin + CGPoint(x: newValue.size.width/2, y: newValue.size.height/2)
      animate(to: newBounds, forProperty: "bounds")
      animate(to: newPosition, forProperty: "position")
      frame = newValue
    } }
  
  @objc open var backdropColor: UIColor? {
    get { return backgroundColor }
    set { if backdropColor == newValue { return }; animate(to: newValue?.cgColor, forProperty: "backgroundColor"); layer.backgroundColor = newValue?.cgColor } }
  
  open var x: CGFloat {
    get { return frame.origin.x }
    set { var newSite = site; newSite.origin.x = newValue; site = newSite } }
  open var y: CGFloat {
    get { return frame.origin.y }
    set { var newSite = site; newSite.origin.y = newValue; site = newSite } }
  open var width: CGFloat {
    get { return frame.size.width }
    set { var newSite = site; newSite.size.width = newValue; site = newSite } }
  open var height: CGFloat {
    get { return frame.size.height }
    set { var newSite = site; newSite.size.height = newValue; site = newSite } }
  open var origin: CGPoint {
    get { return frame.origin }
    set { var newSite = site; newSite.origin = newValue; site = newSite } }
  open var size: CGSize {
    get { return frame.size }
    set { var newSite = site; newSite.size = newValue; site = newSite } }
  
  
  open var left: CGFloat { get { return site.origin.x } }
  open var right: CGFloat { get { return left + width } }
  open var top: CGFloat { get { return site.origin.y } }
  open var bottom: CGFloat { get { return top + height } }
  
  
  
  // Layer
  /** A shortcut to the `opacity` of the view's layer */
  open var opacity: Float {
    get { return layer.opacity }
    set { if opacity == newValue { return }; animate(to: newValue, forProperty: "opacity"); layer.opacity = newValue  } }
  /** A shortcut to the `cornerRadius` of the view's layer. The reason for the different name is to allow compatibility with existing code bases which have already added the `cornerRadius` property to UIView via an extension. */
  @objc open var cornerRounding: CGFloat {
    get { return layer.cornerRadius }
    set { if cornerRounding ~= newValue { return }; animate(to: newValue, forProperty: "cornerRadius"); layer.cornerRadius = newValue } }
  /// Shadow
  open var shadow: Shadow {
    get { return Shadow(opacity: layer.shadowOpacity, radius: layer.shadowRadius, offset: layer.shadowOffset, color: UIColor(cgColor: layer.shadowColor ?? UIColor.black.cgColor)) }
    set {
      if shadow.opacity != newValue.opacity { animate(to: newValue.opacity, forProperty: "shadowOpacity"); layer.shadowOpacity = newValue.opacity }
      if shadow.radius != newValue.radius { animate(to: newValue.radius, forProperty: "shadowRadius"); layer.shadowRadius = newValue.radius }
      if shadow.offset != newValue.offset { animate(to: newValue.offset, forProperty: "shadowOffset"); layer.shadowOffset = newValue.offset }
      if shadow.color != newValue.color { animate(to: newValue.color.cgColor, forProperty: "shadowColor"); layer.shadowColor = newValue.color.cgColor }
    } }
  open var masksToBounds: Bool {
    get { return layer.masksToBounds }
    set { layer.masksToBounds = newValue } }
  open var shadowPath: CGPath? {
    get { return layer.shadowPath }
    set { layer.shadowPath = newValue } }
}



extension UIView {
  // These shortcuts are for debugging convenience
  public func red () { backgroundColor = UIColor.red }
  public func blue () { backgroundColor = UIColor.blue }
  public func green () { backgroundColor = UIColor.green }
  public func yellow () { backgroundColor = UIColor.yellow }
  public func purple () { backgroundColor = UIColor.purple }
  public func cyan () { backgroundColor = UIColor.cyan }
  public func white () { backgroundColor = UIColor.white }
  public func black () { backgroundColor = UIColor.black }
  public func lightGray () { backgroundColor = UIColor.lightGray }
  public func darkGray () { backgroundColor = UIColor.darkGray }
  public func printFrame(_ tag: String? = nil) {
    print("\(tag != nil ? "\(tag!) : " : "")(x:\(x), y:\(y), width:\(width), height:\(height))")
  }
}


extension UIView {
  public var uiImage: UIImage? {
    if #available(iOS 10, *) {
      let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
      return renderer.image { ctx in self.drawHierarchy(in: self.bounds, afterScreenUpdates: true) }
    }
    return nil
  }
}


public extension UIView {
  public func addSubviews (_ subviews: [UIView]) {
    subviews.forEach({ addSubview($0) })
  }
}
