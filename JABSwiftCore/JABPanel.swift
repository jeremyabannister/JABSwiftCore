//
//  JABPanel.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/19/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

open class JABPanel: JABTouchableView {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    open var panelDelegate: JABPanelDelegate?
    
    // MARK: Subscribers
    var subscribers = [JABPanelChangeSubscriber]()
    
    // MARK: State
    open var heightToWidthRatio = CGFloat(1) {
        didSet {
            notifySubscribersOfChange()
        }
    }
    open var staticAdditionToHeight = CGFloat(0)
    open var shouldPassOnTouchNotification = true
    
    fileprivate var initialTouchLocation = CGPoint()
    fileprivate var longPressTimer = Timer()
    
    
    
    // MARK: UI
    
    // MARK: Parameters
    
    
    
    
    
    // **********************************************************************************************************************
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Init
    // MARK:
    
    override public init (frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        clipsToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Should not be initializing from coder \(self)", terminator: "")
    }
    
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    
    // MARK: All
    override open func addAllUI() {
        
    }
    
    override open func updateAllUI() {
        
    }
    
    
    
    // MARK: Adding
    
    
    // MARK: Individual UI Elements (delete this)
    // MARK:
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    fileprivate func restartLongPressTimer () {
        cancelLongPressTimer()
        longPressTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(JABPanel.longPressTimerTriggered), userInfo: nil, repeats: false)
    }
    
    fileprivate func cancelLongPressTimer () {
        longPressTimer.invalidate()
    }
    
    open func longPressTimerTriggered () {
        panelDelegate?.panelWasLongPressed(self)
    }
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    override open func touchDidBegin(_ touchManager: JABTouchManager) {
        guard let touchRecognizer = touchManager.touchRecognizer else { return }
        initialTouchLocation = touchRecognizer.location(in: staticOnScreenView)
        
        restartLongPressTimer()
        
    }
    
    override open func touchDidChange(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        guard let touchRecognizer = touchManager.touchRecognizer else { return }
        if touchRecognizer.location(in: staticOnScreenView).distanceToPoint(initialTouchLocation) > 7 {
            cancelLongPressTimer()
        }
        
    }
    
    override open func touchDidEnd(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        guard let touchRecognizer = touchManager.touchRecognizer else { return }
        if shouldPassOnTouchNotification {
            if relativeFrame.containsPoint(touchRecognizer.location(in: self)) {
                if initialTouchLocation.distanceToPoint(touchRecognizer.location(in: staticOnScreenView)) < 10 {
                    panelDelegate?.panelWasTapped(self)
                }
            }
        }
        
        cancelLongPressTimer()
    }
    
    override open func touchDidCancel(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        cancelLongPressTimer()
    }
    
    
    
    // MARK:
    // MARK: Subscribers
    // MARK:
    
    open func addSubscriber(_ subscriber: JABPanelChangeSubscriber) {
        
        for currentSubscriber in subscribers {
            if currentSubscriber === subscriber {
                return
            }
        }
        
        subscribers.append(subscriber)
        
    }
    
    open func removeSubscriber(_ subscriber: JABPanelChangeSubscriber) {
        
        for i in 0..<subscribers.count {
            if subscribers[i] === subscriber {
                subscribers.remove(at: i)
            }
        }
        
    }
    
    open func subscriberIsAlreadySubscribed(_ subscriber: JABPanelChangeSubscriber) -> Bool {
        
        for i in 0..<subscribers.count {
            if subscribers[i] === subscriber {
                return true
            }
        }
        
        return false
    }
    
    open func notifySubscribersOfChange () {
        
        for subscriber in subscribers {
            subscriber.panelContentsDidChange(self)
        }
        
    }

}



public protocol JABPanelDelegate: class {
    func panelWasTapped(_ panel: JABPanel)
    func panelWasLongPressed (_ panel: JABPanel)
}

public protocol JABPanelChangeSubscriber: class {
    func panelContentsDidChange(_ panel: JABPanel)
}



// MARK:
// MARK: Equatable
// MARK:

public func == (lhs: JABPanel, rhs: JABPanel) -> Bool {
    return lhs === rhs
}

