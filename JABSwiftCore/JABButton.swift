//
//  JABButton.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/17/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

open class JABButton: JABTouchableView {
    
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // Override
    override open var backgroundColor: UIColor? {
        get { return background.backgroundColor }
        set { undimmedBackgroundColor = newValue; configureBackground() }
    }
    override open var cornerRadius: CGFloat {
        get { return background.cornerRadius }
        set { background.cornerRadius = newValue }
    }
    
    // MARK: Delegate
    open var buttonDelegate: JABButtonDelegate?
    
    // MARK: State
    open var visualPressedExtent: CGFloat = 0
    open var pressDuration: TimeInterval = 0.05
    open var pressDelay: TimeInterval = 0
    
    open var dimsWhenPressed = true
    open var dimFraction: CGFloat = 0.8
    fileprivate var undimmedBackgroundColor: UIColor?
    
    fileprivate var pressDelayTimer: Timer?
    fileprivate var isPressed = false
    
    
    // MARK: UI
    fileprivate let background = UIView()
    
    
    // MARK: Parameters
    
    
    
    // **********************************************************************************************************************
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Init
    // MARK:
    
    override public init (frame: CGRect = CGRect.zero, shouldAddAllUI: Bool = true) {
        super.init(frame: frame, shouldAddAllUI: shouldAddAllUI)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    // MARK: All
    override open func addAllUI () {
        
        addBackground()
        
    }
    
    override open func updateAllUI() {
        
        
        configureBackground()
        positionBackground()
        
    }
    
    
    // MARK: Adding
    fileprivate func addBackground () {
        addSubview(background)
    }
    
    
    
    // MARK: Background
    fileprivate func configureBackground () {
        let view = background
        if dimsWhenPressed {
            view.backgroundColor = undimmedBackgroundColor?.dim(1 - (visualPressedExtent * (1 - dimFraction)))
        }
        else { view.backgroundColor = undimmedBackgroundColor }
    }
    
    fileprivate func positionBackground () {
        let view = background
        var newFrame = CGRect.zero
        
        newFrame.size.width = width
        newFrame.size.height = height
        
        newFrame.origin.x = (width - newFrame.size.width)/2
        newFrame.origin.y = (height - newFrame.size.height)/2
        
        view.frame = newFrame
    }
    
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    
    // MARK: Touch
    open func cancelTouch () {
        touchManager?.cancelTouch()
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
        if animated { animatedUpdate() } else { updateAllUI() }
    }
    
    // MARK: Timer
    open func animateUsingTimer (_ timer: Timer) {
        guard let animationDuration = timer.userInfo as? TimeInterval else { return }
        animatedUpdate(duration: animationDuration)
    }
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Touch Manager
    override open func touchDidBegin(_ touchManager: JABTouchManager) {
        isPressed = true
        visualPressedExtent = 1
        if pressDelay != 0 {
            animatedUpdate(duration: pressDuration, delay: pressDelay)
            pressDelayTimer = Timer.scheduledTimer(timeInterval: pressDelay, target: self, selector: #selector(animateUsingTimer(_:)), userInfo: pressDuration, repeats: false)
        }
        else { animatedUpdate(duration: pressDuration) }
        buttonDelegate?.buttonWasTouched(self)
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



public protocol JABButtonDelegate {
    func buttonWasTouched(_ button: JABButton)
    func buttonWasUntouched(_ button: JABButton, wasTriggered: Bool)
}
