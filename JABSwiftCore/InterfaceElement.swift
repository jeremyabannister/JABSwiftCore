//
//  AnimatableEntity.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/26/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public protocol InterfaceElement: NSObjectProtocol {
  var layer: CALayer { get }
}

public extension InterfaceElement {
  public func animate (to newValue: Any?, forProperty propertyString: String) {
    if GlobalAnimationState.shouldAnimateChangesLookupTable[self.objectIdentifier] != true { return }
    guard let animationParameters = GlobalAnimationState.animationParametersLookupTable[self.objectIdentifier] else { return }
    let animation = CABasicAnimation(keyPath: propertyString, fromValue: currentlyPresentedValue(forProperty: propertyString), toValue: newValue)
    animation.duration = animationParameters.duration
    animation.timingFunction = animationParameters.timingFunction.mediaTimingFunction
    animation.fillMode = kCAFillModeForwards
    layer.removeAnimation(forKey: propertyString)
    layer.add(animation, forKey: propertyString)
  }
  
  public func currentlyPresentedValue (forProperty propertyString: String) -> Any? {
    let layerToQuery = layer.animation(forKey: propertyString) == nil ? layer : layer.presentation() ?? layer
    return layerToQuery.value(forKey: propertyString)
  }
}

extension UIView: InterfaceElement { }
extension CALayer: InterfaceElement {
  public var layer: CALayer { return self }
}

public extension Array where Element: InterfaceElement {
  public var asInterfaceElements: [InterfaceElement?] { return self as [InterfaceElement?] }
}




// MARK: - Convenience
public extension InterfaceElement {
  // These shortcuts are for debugging convenience
  public func red () { layer.backgroundColor = UIColor.red.cgColor }
  public func blue () { layer.backgroundColor = UIColor.blue.cgColor }
  public func green () { layer.backgroundColor = UIColor.green.cgColor }
  public func yellow () { layer.backgroundColor = UIColor.yellow.cgColor }
  public func purple () { layer.backgroundColor = UIColor.purple.cgColor }
  public func cyan () { layer.backgroundColor = UIColor.cyan.cgColor }
  public func white () { layer.backgroundColor = UIColor.white.cgColor }
  public func black () { layer.backgroundColor = UIColor.black.cgColor }
  public func lightGray () { layer.backgroundColor = UIColor.lightGray.cgColor }
  public func darkGray () { layer.backgroundColor = UIColor.darkGray.cgColor }
}


public extension InterfaceElement {
  public var x: CGFloat {
    get { return layer.frame.origin.x }
    set { var newFrame = layer.frame; newFrame.origin.x = newValue; layer.site = newFrame } }
  public var y: CGFloat {
    get { return layer.frame.origin.y }
    set { var newFrame = layer.frame; newFrame.origin.y = newValue; layer.site = newFrame } }
  public var width: CGFloat {
    get { return layer.frame.size.width }
    set { var newFrame = layer.frame; newFrame.size.width = newValue; layer.site = newFrame } }
  public var height: CGFloat {
    get { return layer.frame.size.height }
    set { var newFrame = layer.frame; newFrame.size.height = newValue; layer.site = newFrame } }
  public var origin: CGPoint {
    get { return layer.frame.origin }
    set { var newFrame = layer.frame; newFrame.origin = newValue; layer.site = newFrame } }
  public var size: CGSize {
    get { return layer.frame.size }
    set { var newFrame = layer.frame; newFrame.size = newValue; layer.site = newFrame } }
  
  
  public var left: CGFloat { return x }
  public var top: CGFloat { return y }
  public var right: CGFloat { return left + width }
  public var bottom: CGFloat { return top + height }
}

public extension InterfaceElement {
  public var frame_: CGRect {
    get { return site }
    set { site = newValue}
  }
}

public extension InterfaceElement {
  public var site: CGRect {
    get { return layer.frame }
    set {
      if site ~= newValue { return }
      // Turns out the bounds origin is not always (0, 0), for example in the case of a scrolled UITableView
      let newBounds = CGRect(origin: layer.bounds.origin, size: newValue.size)
      let newPosition = newValue.origin + CGPoint(x: newValue.size.width/2, y: newValue.size.height/2)
      animate(to: newBounds, forProperty: "bounds")
      animate(to: newPosition, forProperty: "position")
      layer.frame = newValue
    } }
  
  public var backdropColor: UIColor? {
    get { return UIColor(cgColor: layer.backgroundColor) }
    set {
      if backdropColor == newValue { return }
      animate(to: newValue?.cgColor, forProperty: "backgroundColor")
      layer.backgroundColor = newValue?.cgColor
    } }
  
  public var opacity: Float {
    get { return layer.opacity }
    set {
      if opacity == newValue { return }
      animate(to: newValue, forProperty: "opacity")
      layer.opacity = newValue
    } }
  public var cornerRounding: CGFloat {
    get { return layer.cornerRadius }
    set {
      if cornerRounding ~= newValue { return }
      animate(to: newValue, forProperty: "cornerRadius")
      layer.cornerRadius = newValue
    } }
  
  /// Shadow
  public var shadow: Shadow {
    get { return Shadow(opacity: layer.shadowOpacity, radius: layer.shadowRadius, offset: layer.shadowOffset, color: UIColor(cgColor: layer.shadowColor ?? UIColor.black.cgColor)) }
    set {
      if shadow.opacity != newValue.opacity {
        animate(to: newValue.opacity, forProperty: "shadowOpacity")
        layer.shadowOpacity = newValue.opacity
      }
      if shadow.radius != newValue.radius {
        animate(to: newValue.radius, forProperty: "shadowRadius")
        layer.shadowRadius = newValue.radius
      }
      if shadow.offset != newValue.offset {
        animate(to: newValue.offset, forProperty: "shadowOffset")
        layer.shadowOffset = newValue.offset
      }
      if shadow.color != newValue.color {
        animate(to: newValue.color.cgColor, forProperty: "shadowColor")
        layer.shadowColor = newValue.color.cgColor
      }
    } }
  public var masksToBounds: Bool {
    get { return layer.masksToBounds }
    set { layer.masksToBounds = newValue } }
  public var shadowPath: CGPath? {
    get { return layer.shadowPath }
    set { layer.shadowPath = newValue } }
}
