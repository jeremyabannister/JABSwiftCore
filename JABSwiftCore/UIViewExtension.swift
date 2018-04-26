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
      animate(to: newBounds, forProperty: .bounds)
      animate(to: newPosition, forProperty: .position)
      frame = newValue
    } }
  
  @objc open var backdropColor: UIColor? {
    get { return backgroundColor }
    set { if backdropColor == newValue { return }; animate(to: newValue?.cgColor, forProperty: .backgroundColor); layer.backgroundColor = newValue?.cgColor } }
  
  ///A shortcut to the view's `frame.origin.x`
  open var x: CGFloat {
    get { return frame.origin.x }
    set { var newSite = site; newSite.origin.x = newValue; site = newSite } }
  /// A shortcut to the view's `frame.origin.y`
  open var y: CGFloat {
    get { return frame.origin.y }
    set { var newSite = site; newSite.origin.y = newValue; site = newSite } }
  /// A shortcut to the view's `frame.size.width`
  open var width: CGFloat {
    get { return frame.size.width }
    set { var newSite = site; newSite.size.width = newValue; site = newSite } }
  /// A shortcut to the view's `frame.size.height`
  open var height: CGFloat {
    get { return frame.size.height }
    set { var newSite = site; newSite.size.height = newValue; site = newSite } }
  /// A shortcut to the view's `frame.origin`
  open var origin: CGPoint {
    get { return frame.origin }
    set { var newSite = site; newSite.origin = newValue; site = newSite } }
  /// A shortcut to the view's `frame.size`
  open var size: CGSize {
    get { return frame.size }
    set { var newSite = site; newSite.size = newValue; site = newSite } }
  
  
  /**
   The x-coordinate of the left side of the view.
   
   - note: `myView.left` will always be equal to `myView.x`, but sometimes it is more descriptive in your code to use the word "left", particularly when used in conjunction with `myView.right`
   */
  open var left: CGFloat { get { return site.origin.x } }
  /**
   The x-coordinate of the right side of the view.
   
   - note: This is equal to `frame.origin.x + frame.size.width`
   */
  open var right: CGFloat { get { return left + width } }
  /**
   The y-coordinate of the top side of the view.
   
   - note: `myView.top` will always be equal to `myView.y`, but sometimes it is more descriptive in your code to use the word "top", particularly when used in conjunction with `myView.bottom`
   */
  open var top: CGFloat { get { return site.origin.y } }
  /**
   The y-coordinate of the bottom side of the view.
   
   - note: This is equal to `frame.origin.y + frame.size.height`
   */
  open var bottom: CGFloat { get { return top + height } }
  
  
  
  // Layer
  /** A shortcut to the `opacity` of the view's layer */
  open var opacity: Float {
    get { return layer.opacity }
    set { if opacity == newValue { return }; animate(to: newValue, forProperty: .opacity); layer.opacity = newValue  } }
  /** A shortcut to the `cornerRadius` of the view's layer. The reason for the different name is to allow compatibility with existing code bases which have already added the `cornerRadius` property to UIView via an extension. */
  @objc open var cornerRounding: CGFloat {
    get { return layer.cornerRadius }
    set { if cornerRounding ~= newValue { return }; animate(to: newValue, forProperty: .cornerRadius); layer.cornerRadius = newValue } }
  /// Shadow
  open var shadow: Shadow {
    get { return Shadow(opacity: layer.shadowOpacity, radius: layer.shadowRadius, offset: layer.shadowOffset, color: UIColor(cgColor: layer.shadowColor ?? UIColor.black.cgColor)) }
    set {
      if shadow.opacity != newValue.opacity { animate(to: newValue.opacity, forProperty: .shadowOpacity); layer.shadowOpacity = newValue.opacity }
      if shadow.radius != newValue.radius { animate(to: newValue.radius, forProperty: .shadowRadius); layer.shadowRadius = newValue.radius }
      if shadow.offset != newValue.offset { animate(to: newValue.offset, forProperty: .shadowOffset); layer.shadowOffset = newValue.offset }
      if shadow.color != newValue.color { animate(to: newValue.color.cgColor, forProperty: .shadowColor); layer.shadowColor = newValue.color.cgColor }
    } }
  /** A shortcut to the `masksToBounds` of the view's layer */
  open var masksToBounds: Bool {
    get { return layer.masksToBounds }
    set { layer.masksToBounds = newValue } }
  /** A shortcut to the `shadowOpacity` of the view's layer */
  open var shadowOpacity: Float {
    get { return layer.shadowOpacity }
    set { if shadowOpacity == newValue { return }; animate(to: newValue, forProperty: .shadowOpacity); layer.shadowOpacity = newValue } }
  /** A shortcut to the `shadowRadius` of the view's layer */
  open var shadowRadius: CGFloat {
    get { return layer.shadowRadius }
    set { if shadowRadius == newValue { return }; animate(to: newValue, forProperty: .shadowRadius); layer.shadowRadius = newValue } }
  /** A shortcut to the `shadowOffset` of the view's layer */
  open var shadowOffset: CGSize {
    get { return layer.shadowOffset }
    set { if shadowOffset == newValue { return }; animate(to: newValue, forProperty: .shadowOffset); layer.shadowOffset = newValue } }
  /** A shortcut to the `shadowColor` of the view's layer */
  open var shadowColor: UIColor? {
    get { return UIColor(cgColor: layer.shadowColor ?? UIColor.black.cgColor) }
    set { layer.shadowColor = newValue?.cgColor } }
  /** A shortcut to the `shadowPath` of the view's layer */
  open var shadowPath: CGPath? {
    get { return layer.shadowPath }
    set { layer.shadowPath = newValue } }
  
  
  
  open func freezePresentedShadow () {
    layer.shadowOpacity = layer.presentation()?.shadowOpacity ?? layer.shadowOpacity
    layer.shadowRadius = layer.presentation()?.shadowRadius ?? layer.shadowRadius
    layer.shadowOffset = layer.presentation()?.shadowOffset ?? layer.shadowOffset
    layer.shadowColor = layer.presentation()?.shadowColor ?? layer.shadowColor
  }
  
  open func applyShadow (_ shadow: (opacity: Float, radius: CGFloat, offset: CGSize, color: UIColor)) {
    self.shadowOpacity = shadow.opacity
    self.shadowRadius = shadow.radius
    self.shadowOffset = shadow.offset
    self.shadowColor = shadow.color
  }
  
  
  
  // Animation
  private enum AnimatableProperty: String {
    case bounds, position, backgroundColor, opacity, cornerRadius, shadowOpacity, shadowRadius, shadowOffset, shadowColor
  }
  private func animate (to newValue: Any?, forProperty property: AnimatableProperty) {
    if shouldAnimateChangesLookupTable[self.objectIdentifier] != true && !JABView.isGeneratingAnimatedUpdate { return }
    let animationParameters = animationParametersLookupTable[self.objectIdentifier] ?? AnimationParameters(duration: JABView.animateDuration, timingFunction: JABView.animationTimingFunction, completion: nil)
    let animation = CABasicAnimation(keyPath: property.rawValue, fromValue: currentlyPresentedValue(for: property), toValue: newValue)
    animation.duration = animationParameters.duration
    animation.timingFunction = animationParameters.timingFunction.mediaTimingFunction
    self.layer.removeAnimation(forKey: property.rawValue)
    self.layer.add(animation, forKey: property.rawValue)
  }
  private func currentlyPresentedValue (for property: AnimatableProperty) -> Any? {
    let shouldDeriveFromPresentationLayer = self.layer.animation(forKey: property.rawValue) != nil
    switch property {
    case .bounds:
      return [true: layer.presentation()?.bounds ?? layer.bounds, false: layer.bounds][shouldDeriveFromPresentationLayer]!
    case .position:
      return [true: layer.presentation()?.position ?? layer.position, false: layer.position][shouldDeriveFromPresentationLayer]!
    case .backgroundColor:
      return [true: layer.presentation()?.backgroundColor ?? layer.backgroundColor, false: layer.backgroundColor][shouldDeriveFromPresentationLayer]!
    case .opacity:
      return [true: layer.presentation()?.opacity ?? layer.opacity, false: layer.opacity][shouldDeriveFromPresentationLayer]!
    case .cornerRadius:
      return [true: layer.presentation()?.cornerRadius ?? layer.cornerRadius, false: layer.cornerRadius][shouldDeriveFromPresentationLayer]!
    case .shadowOpacity:
      return [true: layer.presentation()?.shadowOpacity ?? layer.shadowOpacity, false: layer.shadowOpacity][shouldDeriveFromPresentationLayer]!
    case .shadowRadius:
      return [true: layer.presentation()?.shadowRadius ?? layer.shadowRadius, false: layer.shadowRadius][shouldDeriveFromPresentationLayer]!
    case .shadowOffset:
      return [true: layer.presentation()?.shadowOffset ?? layer.shadowOffset, false: layer.shadowOffset][shouldDeriveFromPresentationLayer]!
    case .shadowColor:
      return [true: layer.presentation()?.shadowColor ?? layer.shadowColor, false: layer.shadowColor][shouldDeriveFromPresentationLayer]!
    }
  }
  
  
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


public struct Shadow {
  public let opacity: Float
  public let radius: CGFloat
  public let offset: CGSize
  public let color: UIColor
  
  public init (opacity: Float, radius: CGFloat, offset: CGSize, color: UIColor) {
    self.opacity = opacity
    self.radius = radius
    self.offset = offset
    self.color = color
  }
  
  public static var none: Shadow { return Shadow(opacity: 0, radius: 0, offset: .zero, color: .black) }
  
  public static func == (lhs: Shadow, rhs: Shadow) -> Bool { return (lhs.opacity == rhs.opacity) && (lhs.radius == rhs.radius) && (lhs.offset == rhs.offset) && (lhs.color == rhs.color) }
}


public class JABAnimationParameters {
  var duration: TimeInterval? = nil
  var timingFunction: TimingFunction? = nil
  var completion: (() -> ())? = nil
}

fileprivate var animationParametersKey = "AnimationParametersKey"

extension UIView {
  var animationParameters: JABAnimationParameters {
    get { return (retrieveObject(forKey: &animationParametersKey) as? JABAnimationParameters) ?? JABAnimationParameters() }
    set { storeObject(newValue, forKey: &animationParametersKey) }
  }
  
  func setAnimationDuration (_ animationDuration: TimeInterval?) {
    let newAnimationParameters = animationParameters
    newAnimationParameters.duration = animationDuration
    animationParameters = newAnimationParameters
  }
  
  func setTimingFunction (_ timingFunction: TimingFunction?) {
    let newAnimationParameters = animationParameters
    newAnimationParameters.timingFunction = timingFunction
    animationParameters = newAnimationParameters
  }
  
  func setAnimationCompletion (_ completion: (() -> ())?) {
    let newAnimationParameters = animationParameters
    newAnimationParameters.completion = completion
    animationParameters = newAnimationParameters
  }
}



public extension UIView {
  public func addSubviews (_ subviews: [UIView]) {
    subviews.forEach({ addSubview($0) })
  }
}
