//
//  JABButton.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/17/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

open class JABButton: JABTouchableView, AnimatableInterfaceForUIView {
  
  // MARK:
  // MARK: Properties
  // MARK:
  
  // Override
  open var backdropColor: UIColor? {
    get { return holder.backdropColor }
    set { undimmedBackdropColor = newValue ?? .clear; configureHolder() }
  }
  open var cornerRounding: CGFloat {
    get { return holder.cornerRounding }
    set { holder.cornerRounding = newValue }
  }
  
  // MARK: Delegate
  weak open var buttonDelegate: JABButtonDelegate?
  
  // MARK: State
  open var visualPressedExtent: CGFloat = 0
  open var pressDuration: TimeInterval = 0.05
  open var pressDelay: TimeInterval = 0
  open var dimsWhenPressed = false
  open var dimFraction: CGFloat = 0.8
  open var topOfContent: CGFloat { return self.top }
  
  fileprivate var isPressed = false
  fileprivate var undimmedBackdropColor: UIColor = .clear
  fileprivate var pressDelayTimer: Timer?
  
  open var interfaceElements: [InterfaceElement?] { return [holder] }
  
  // MARK: UI
  fileprivate let holder = UIView()
  
  
  // MARK: Parameters
  
  
  
  // **********************************************************************************************************************
  
  
  // MARK:
  // MARK: Methods
  // MARK:
  
  // MARK:
  // MARK: Init
  // MARK:
  
  override public init () {
    super.init()
    addUI()
  }
  
  public required init? (coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  
  // MARK:
  // MARK: UI
  // MARK:
  
  // MARK: All
  open func addUI () {
    addHolder()
  }
  
  open func updateUI() {
    
    configureHolder()
    positionHolder()
    
  }
  
  
  // MARK: Adding
  fileprivate func addHolder () {
    addSubview(holder)
  }
  
  
  
  // MARK: Holder
  fileprivate func configureHolder () {
    let view = holder
    if dimsWhenPressed { view.backdropColor = undimmedBackdropColor.dim(1 - (visualPressedExtent * (1 - dimFraction))) }
    else { view.backdropColor = undimmedBackdropColor }
  }
  
  fileprivate func positionHolder () {
    let view = holder
    var newSite = CGRect.zero
    
    newSite.size.width = width
    newSite.size.height = height
    
    newSite.origin.x = (width - newSite.size.width)/2
    newSite.origin.y = (height - newSite.size.height)/2
    
    view.site = newSite
  }
  
  
  
  // MARK:
  // MARK: Actions
  // MARK:
  
  // MARK: Override
  override open func addSubview(_ view: UIView) {
    if view == holder { super.addSubview(view) }
    else { holder.addSubview(view) }
  }
  
  // MARK: Touch
  open func cancelTouch () {
    touchManager?.cancelTouch()
  }
  
  open func simulatePress () {
    beginTouch { (completed) in self.endTouch(wasTriggered: true) }
  }
  
  fileprivate func beginTouch (completion: @escaping (Bool) -> () = { (completed) in }) {
    isPressed = true
    visualPressedExtent = 1
    if pressDelay != 0 {
      animatedUpdate(duration: pressDuration, completion: completion)
      pressDelayTimer = Timer.scheduledTimer(timeInterval: pressDelay, target: self, selector: #selector(animateUsingTimer(_:)), userInfo: pressDuration, repeats: false)
    }
    else { animatedUpdate(duration: pressDuration, completion: completion) }
    buttonDelegate?.buttonWasTouched(self)
  }
  
  fileprivate func endTouch (wasTriggered: Bool) {
    isPressed = false
    visualPressedExtent = 0
    pressDelayTimer?.invalidate()
    animatedUpdate(duration: pressDuration)
    buttonDelegate?.buttonWasUntouched(self, wasTriggered: wasTriggered)
  }
  
  
  // MARK: Visual
  open func updateVisualPressedExtent (to newVisualPressedExtent: CGFloat, animated: Bool = false) {
    visualPressedExtent = newVisualPressedExtent
    if animated { animatedUpdate() } else { updateUI() }
  }
  
  // MARK: Timer
  @objc open func animateUsingTimer (_ timer: Timer) {
    guard let animationDuration = timer.userInfo as? TimeInterval else { return }
    animatedUpdate(duration: animationDuration)
  }
  
  
  // MARK:
  // MARK: Delegate Methods
  // MARK:
  
  // MARK: Touch Manager
  override open func touchDidBegin(_ touchManager: JABTouchManager) {
    beginTouch()
  }
  
  override open func touchDidChange(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
    guard let touchRecognizer = touchManager.touchRecognizer else { return }
    let wasPressed = isPressed
    isPressed = self.bounds.contains(touchRecognizer.location(in: self))
    if isPressed != wasPressed {
      visualPressedExtent = [true: 1, false: 0][isPressed]!
      animatedUpdate(duration: pressDuration)
    }
  }
  
  override open func touchDidEnd(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
    guard let touchRecognizer = touchManager.touchRecognizer else { return }
    endTouch(wasTriggered: bounds.contains(touchRecognizer.location(in: self)))
  }
  
  override open func touchDidCancel(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
    endTouch(wasTriggered: false)
  }
}


public protocol JABButtonDelegate: class {
  func buttonWasTouched(_ button: JABButton)
  func buttonWasUntouched(_ button: JABButton, wasTriggered: Bool)
}

public extension JABButtonDelegate {
  func buttonWasTouched (_ button: JABButton) { }
  func buttonWasUntouched (_ button: JABButton, wasTriggered: Bool) { }
}
