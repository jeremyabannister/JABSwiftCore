//
//  View.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/23/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

// MARK: - Initial Declaration
open class View: UniquelyIdentifiableObject {
  // Root View
  public static var rootView: View?
  
  // Outlet
  public let outlet: VisualOutlet?
  
  // Animatable Properties
  public var frame: Rect = .zero {
    willSet {
      animate(to: newValue, forKeyPath: "frame")
      outlet?.setFrame(newValue)
    }
  }
  public var backgroundColor: Color = .clear {
    willSet {
      animate(to: newValue, forKeyPath: "backgroundColor")
      outlet?.setBackgroundColor(newValue)
    }
  }
  public var opacity: Double = 0 {
    willSet {
      animate(to: newValue, forKeyPath: "opacity")
      outlet?.setOpacity(newValue)
    }
  }
  public var cornerRadius: Double = 0 {
    willSet {
      animate(to: newValue, forKeyPath: "cornerRadius")
      outlet?.setCornerRadius(newValue)
    }
  }
  public var shadow: Shadow = .none {
    willSet {
      animate(to: newValue, forKeyPath: "shadow")
      outlet?.setShadow(newValue)
    }
  }
  
  // Animation Controls
  internal var shouldAnimatedChanges = false
  internal var animationParameters: AnimationParameters?
  
  // Non-Animatable Properties
  public private(set) var superview: View?
  public private(set) var subviews: [View] = []
  public var isUserInteractionEnabled = true { willSet { outlet?.setIsUserInteractionEnabled(newValue) } }
  public var clipsToBounds = false { willSet { outlet?.setClipsToBounds(newValue) } }
  
  // Init
  public init (outlet: VisualOutlet?) {
    self.outlet = outlet
    commonInit()
  }
  
  public init () {
    self.outlet = VisualOutletFactory.createNewOutlet()
    commonInit()
  }
  
  // MARK: - Overridable Methods
  // Overridable Methods
  open func addSubview (_ view: View) {
    if self.isDescendentView(of: view) { printWarning(.addedSuperviewToSubview); return }
    view.removeFromSuperview()
    view.superview = self
    subviews.append(view)
    outlet?.addSubview(view.outlet)
  }
  
  open func bringSubview (toFront subview: View) {
    outlet?.bringSubview(toFront: subview.outlet)
  }
  
  open func commonInit () {
    (self as? Interface)?.addUI() // This kind of coupling feels wrong, but is extremely useful as it removes
  }
}

// MARK: - Non-Overridable Methods
extension View {
  public var originOnScreen: Point? {
    if self == View.rootView { return .zero }
    guard let superviewOrigin = superview?.originOnScreen else { return nil }
    return superviewOrigin + self.origin
  }
  
  public func isDescendentView (of view: View) -> Bool {
    if self == View.rootView { return false }
    return superview?.isDescendentView(of: view) ?? false
  }
  
  public func removeFromSuperview () {
    guard let superview = superview else { return }
    guard let index = superview.subviews.index(of: self) else { return }
    superview.subviews.remove(at: index)
    self.superview = nil
    outlet?.removeFromSuperview()
  }
}

// MARK: - Shortcuts
extension View {
  public var x: Double {
    get { return frame.origin.x }
    set { frame.origin.x = newValue }
  }
  
  public var y: Double {
    get { return frame.origin.y }
    set { frame.origin.y = newValue }
  }
  
  public var width: Double {
    get { return frame.size.width }
    set { frame.size.width = newValue }
  }
  
  public var height: Double {
    get { return frame.size.height }
    set { frame.size.height = newValue }
  }
  
  public var origin: Point {
    get { return frame.origin }
    set { frame.origin = newValue }
  }
  
  public var size: Size {
    get { return frame.size }
    set { frame.size = newValue }
  }
  
  public var left: Double { return x }
  public var right: Double { return x + width }
  public var top: Double { return y }
  public var bottom: Double { return y + height }
}

// MARK: - Animation
private extension View {
  func animate <PropertyType> (to newValue: PropertyType, forKeyPath keyPath: String) {
    guard shouldAnimatedChanges, let animationParameters = animationParameters else { return }
    let fromValue = outlet?.presentedSelf.value(forKey: keyPath) ?? newValue
    let animation = SinglePropertyAnimation(keyPath: keyPath, fromValue: fromValue, toValue: newValue, animationParameters: animationParameters)
    outlet?.removeAnimation(forKey: keyPath)
    outlet?.add(animation, forKey: keyPath)
  }
}

// MARK: - Debug Coloring
extension View {
  public func red () { backgroundColor = .red }
  public func green () { backgroundColor = .green }
  public func blue () { backgroundColor = .blue }
  public func clear () { backgroundColor = .clear }
  public func white () { backgroundColor = .white }
  public func black () { backgroundColor = .black }
}

// MARK: - Debug Logging
private extension View {
  enum Warning: String {
    case addedSuperviewToSubview = "API MISUSE - Do not try to add a superview as a subview of one of its own subviews (or further descendent views)"
  }
  
  func printWarning (_ warning: Warning) {
    print("WARNING: " + warning.rawValue)
  }
}

// MARK: - Equatable
extension View: Equatable {
  public static func == (lhs: View, rhs: View) -> Bool {
    return lhs.isEqual(to: rhs)
  }
}
