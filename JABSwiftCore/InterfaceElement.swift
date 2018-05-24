//
//  AnimatableEntity.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/26/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public protocol InterfaceElement: NSObjectProtocol {
  var layera: CALayer { get }
}

public extension InterfaceElement {
  public func animate (to newValue: Any?, forProperty propertyString: String) {
    if GlobalAnimationState.shouldAnimateChangesLookupTable[self.objectIdentifier] != true { return }
    guard let animationParameters = GlobalAnimationState.animationParametersLookupTable[self.objectIdentifier] else { return }
    let animation = CABasicAnimation(keyPath: propertyString, fromValue: currentlyPresentedValue(forProperty: propertyString), toValue: newValue)
    animation.duration = animationParameters.duration
    animation.timingFunction = animationParameters.timingFunction.mediaTimingFunction
    animation.fillMode = kCAFillModeForwards
    layera.removeAnimation(forKey: propertyString)
    layera.add(animation, forKey: propertyString)
  }
  
  public func currentlyPresentedValue (forProperty propertyString: String) -> Any? {
    let layerToQuery = layera.animation(forKey: propertyString) == nil ? layera : layera.presentation() ?? layera
    return layerToQuery.value(forKey: propertyString)
  }
}

extension UIView: InterfaceElement {
  public var layera: CALayer { return layer }
}
extension CALayer: InterfaceElement {
  public var layera: CALayer { return self }
}

public extension Array where Element: InterfaceElement {
  public var asInterfaceElements: [InterfaceElement?] { return self as [InterfaceElement?] }
}




// MARK: - Convenience
public extension InterfaceElement {
  // These shortcuts are for debugging convenience
  public func red () { layera.backgroundColor = UIColor.red.cgColor }
  public func blue () { layera.backgroundColor = UIColor.blue.cgColor }
  public func green () { layera.backgroundColor = UIColor.green.cgColor }
  public func yellow () { layera.backgroundColor = UIColor.yellow.cgColor }
  public func purple () { layera.backgroundColor = UIColor.purple.cgColor }
  public func cyan () { layera.backgroundColor = UIColor.cyan.cgColor }
  public func white () { layera.backgroundColor = UIColor.white.cgColor }
  public func black () { layera.backgroundColor = UIColor.black.cgColor }
  public func lightGray () { layera.backgroundColor = UIColor.lightGray.cgColor }
  public func darkGray () { layera.backgroundColor = UIColor.darkGray.cgColor }
}


public extension InterfaceElement {
  public var x: CGFloat {
    get { return layera.frame.origin.x }
    set { var newFrame = layera.frame; newFrame.origin.x = newValue; layera.site = newFrame } }
  public var y: CGFloat {
    get { return layera.frame.origin.y }
    set { var newFrame = layera.frame; newFrame.origin.y = newValue; layera.site = newFrame } }
  public var width: CGFloat {
    get { return layera.frame.size.width }
    set { var newFrame = layera.frame; newFrame.size.width = newValue; layera.site = newFrame } }
  public var height: CGFloat {
    get { return layera.frame.size.height }
    set { var newFrame = layera.frame; newFrame.size.height = newValue; layera.site = newFrame } }
  public var origin: CGPoint {
    get { return layera.frame.origin }
    set { var newFrame = layera.frame; newFrame.origin = newValue; layera.site = newFrame } }
  public var size: CGSize {
    get { return layera.frame.size }
    set { var newFrame = layera.frame; newFrame.size = newValue; layera.site = newFrame } }
  
  
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
    get { return layera.frame }
    set {
      if site ~= newValue { return }
      // Turns out the bounds origin is not always (0, 0), for example in the case of a scrolled UITableView
      let newBounds = CGRect(origin: layera.bounds.origin, size: newValue.size)
      let newPosition = newValue.origin + CGPoint(x: newValue.size.width/2, y: newValue.size.height/2)
      animate(to: newBounds, forProperty: "bounds")
      animate(to: newPosition, forProperty: "position")
      layera.frame = newValue
    } }
  
  public var backdropColor: UIColor? {
    get { return UIColor(cgColor: layera.backgroundColor) }
    set {
      if backdropColor == newValue { return }
      animate(to: newValue?.cgColor, forProperty: "backgroundColor")
      layera.backgroundColor = newValue?.cgColor
    } }
  
  public var opacity: Float {
    get { return layera.opacity }
    set {
      if opacity == newValue { return }
      animate(to: newValue, forProperty: "opacity")
      layera.opacity = newValue
    } }
  public var cornerRounding: CGFloat {
    get { return layera.cornerRadius }
    set {
      if cornerRounding ~= newValue { return }
      animate(to: newValue, forProperty: "cornerRadius")
      layera.cornerRadius = newValue
    } }
  
  /// Shadow
  public var shadow: Shadow {
    get { return Shadow(opacity: Double(layera.shadowOpacity), radius: Double(layera.shadowRadius), offset: Size(Double(layera.shadowOffset.width), Double(layera.shadowOffset.height)), color: UIColor(cgColor: layera.shadowColor ?? UIColor.black.cgColor).color) }
    set {
      if shadow.opacity != newValue.opacity {
        let castedValue = Float(newValue.opacity)
        animate(to: castedValue, forProperty: "shadowOpacity")
        layera.shadowOpacity = castedValue
      }
      if shadow.radius != newValue.radius {
        let castedValue = CGFloat(newValue.radius)
        animate(to: castedValue, forProperty: "shadowRadius")
        layera.shadowRadius = castedValue
      }
      if shadow.offset != newValue.offset {
        let castedValue = CGSize(width: newValue.offset.width, height: newValue.offset.height)
        animate(to: castedValue, forProperty: "shadowOffset")
        layera.shadowOffset = castedValue
      }
      if shadow.color != newValue.color {
        let castedValue = UIColor(color: newValue.color).cgColor
        animate(to: castedValue, forProperty: "shadowColor")
        layera.shadowColor = castedValue
      }
    } }
  public var masksToBounds: Bool {
    get { return layera.masksToBounds }
    set { layera.masksToBounds = newValue } }
  public var shadowPath: CGPath? {
    get { return layera.shadowPath }
    set { layera.shadowPath = newValue } }
}
