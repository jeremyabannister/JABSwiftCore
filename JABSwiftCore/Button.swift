//
//  Button.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/8/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

// MARK: - Public API
extension Button {
  public func whenButtonIsTouched (callback: @escaping (Button)->()) {
    callbackForWhenButtonIsTouched = callback
  }
  
  public func whenButtonIsUntouched (callback: @escaping (Button, Bool)->()) {
    callbackForWhenButtonIsUntouched = callback
  }
  
  public func simulatePress () {
    beginTouch { (_) in self.endTouch(wasTriggered: true) }
  }
}

// MARK: - Class Declaration
open class Button: TouchableView {
  
  // Override
  open override var backgroundColor: Color {
    get { return background.backgroundColor }
    set {
      normalBackgroundColor = newValue
      configureBackground()
    }
  }
  open override var cornerRadius: Double {
    get { return background.cornerRadius }
    set { background.cornerRadius = newValue }
  }
  open override func addSubview (_ view: View) {
    if view == background { super.addSubview(view) }
    else { background.addSubview(view) }
  }
  
  // Public
  public private(set) var visualPressedExtent: Double = 0
  open var pressDuration: TimeInterval = 0.05
  open var pressDelay: TimeInterval = 0
  open var dimsWhenPressed = false
  open var dimFraction: Double = 0.8
  
  // Event Callbacks
  private var callbackForWhenButtonIsTouched: ((Button)->())?
  private var callbackForWhenButtonIsUntouched: ((Button, Bool)->())?
  
  // Private
  private var isPressed = false
  private var normalBackgroundColor: Color = .clear
  private var pressDelayTimer: Timer?
  
  // UI
  private let background = View()
  
  // Init
  override open func commonInit () {
    super.commonInit()
    
    whenTouchBegins { [weak self] (_) in
      self?.beginTouch()
    }
    
    whenTouchChanges { [weak self] (touchEvent) in
      self?.changeTouch(touchEvent: touchEvent)
    }
    
    whenTouchEnds { [weak self] (touchEvent) in
      guard let `self` = self else { return }
      self.endTouch(wasTriggered: self.isPressed)
    }
    
    whenTouchCancels { [weak self] (touchEvent) in
      self?.endTouch(wasTriggered: false)
    }
  }
}

// Animatable Interface
extension Button: AnimatableInterface {
  public var interfaceElements: [View?] { return [background] }
  
  public func updateUI () {
    configureBackground()
    positionBackground()
  }
}

// MARK: - UI Methods
private extension Button {
  // Background
  func configureBackground () {
    let view = background
    if dimsWhenPressed { view.backgroundColor = normalBackgroundColor.dimmed(to: 1 - (visualPressedExtent * (1 - dimFraction))) }
    else { view.backgroundColor = normalBackgroundColor }
  }
  
  func positionBackground () {
    let view = background
    var newFrame: Rect = .zero
    
    newFrame.width = width
    newFrame.height = height
    
    newFrame.x = (width - newFrame.width)/2
    newFrame.y = (height - newFrame.height)/2
    
    view.frame = newFrame
  }
}

// MARK: - Core Functionality
private extension Button {
  func beginTouch (completion: @escaping (Bool) -> () = { (completed) in }) {
    isPressed = true
    visualPressedExtent = 1
    if pressDelay != 0 {
      pressDelayTimer = Timer.scheduledTimer(withTimeInterval: pressDelay, repeats: false) { _ in
        self.animatedUpdate(duration: self.pressDuration, completion: completion)
      }
    }
    else { animatedUpdate(duration: pressDuration, completion: completion) }
    callbackForWhenButtonIsTouched?(self)
  }
  
  func changeTouch (touchEvent: TouchEvent) {
    let wasPressed = self.isPressed
    self.isPressed = self.frame.withOrigin(self.originOnScreen)?.contains(touchEvent.locationOnScreen) ?? false
    if self.isPressed != wasPressed {
      self.visualPressedExtent = self.isPressed ? 1 : 0
      self.animatedUpdate(duration: self.pressDuration)
    }
  }
  
  func endTouch (wasTriggered: Bool) {
    isPressed = false
    visualPressedExtent = 0
    animatedUpdate(duration: pressDuration)
    callbackForWhenButtonIsUntouched?(self, wasTriggered)
  }
  
  func updateVisualPressedExtent (to newValue: Double, animated: Bool = false) {
    visualPressedExtent = newValue
    animated ? animatedUpdate() : updateUI()
  }
}


