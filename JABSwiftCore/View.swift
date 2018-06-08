//
//  View.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/23/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

// MARK: - Initial Declaration
open class View: UniquelyIdentifiableObject {
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
  public var isUserInteractionEnabled = true { willSet { outlet?.setIsUserInteractionEnabled(newValue) } }
  public var clipsToBounds = false { willSet { outlet?.setClipsToBounds(newValue) } }
  
  // Init
  public init (outlet: VisualOutlet?) {
    self.outlet = outlet
  }
  
  public init () {
    self.outlet = VisualOutletFactory.createNewOutlet()
  }
  
  // Overridable Methods
  open func addSubview (_ view: View) {
    outlet?.addSubview(view.outlet)
  }
  
  open func bringSubview (toFront subview: View) {
    outlet?.bringSubview(toFront: subview.outlet)
  }
}

// MARK: - Shortcuts
public extension View {
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

// MARK: - Debug
public extension View {
  public func red () { backgroundColor = .red }
  public func green () { backgroundColor = .green }
  public func blue () { backgroundColor = .blue }
  public func clear () { backgroundColor = .clear }
  public func white () { backgroundColor = .white }
  public func black () { backgroundColor = .black }
}
