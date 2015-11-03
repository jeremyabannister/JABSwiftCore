//
//  JABPanel.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/19/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public class JABPanel: JABTouchableView {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    public var panelDelegate: JABPanelDelegate?
    
    // MARK: Subscribers
    var subscribers = [JABPanelChangeSubscriber]()
    
    // MARK: State
    public var heightToWidthRatio = CGFloat(1) {
        didSet {
            notifySubscribersOfChange()
        }
    }
    public var staticAdditionToHeight = CGFloat(0)
    public var shouldPassOnTouchNotification = true
    
    var initialTouchLocation = CGPoint()
    
    
    
    // MARK: UI
    
    // MARK: Parameters
    
    
    
    
    
    // **********************************************************************************************************************
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public override init () {
        super.init()
        
        clipsToBounds = true
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init()
        print("Should not be initializing from coder \(self)", terminator: "")
    }
    
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    
    // MARK: All
    override public func addAllUI() {
        
    }
    
    override public func updateAllUI() {
        
    }
    
    
    
    // MARK: Adding
    
    
    // MARK: Individual UI Elements (delete this)
    // MARK:
    
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    override public func touchDidBegin(gestureRecgonizer: UIGestureRecognizer) {
        initialTouchLocation = gestureRecgonizer.locationInView(staticOnScreenView)
    }
    
    override public func touchDidChange(gestureRecgonizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
    }
    
    override public func touchDidEnd(gestureRecgonizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        if shouldPassOnTouchNotification {
            if relativeFrame.containsPoint(gestureRecgonizer.locationInView(self)) {
                if initialTouchLocation.distanceTo(gestureRecgonizer.locationInView(staticOnScreenView)) < 10 {
                    panelDelegate?.panelWasTapped(self)
                }
            }
        }
    }
    
    override public func touchDidCancel(gestureRecgonizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
    }
    
    
    
    // MARK:
    // MARK: Subscribers
    // MARK:
    
    public func addSubscriber(subscriber: JABPanelChangeSubscriber) {
        
        for currentSubscriber in subscribers {
            if currentSubscriber === subscriber {
                return
            }
        }
        
        subscribers.append(subscriber)
        
    }
    
    public func removeSubscriber(subscriber: JABPanelChangeSubscriber) {
        
        for i in 0..<subscribers.count {
            if subscribers[i] === subscriber {
                subscribers.removeAtIndex(i)
            }
        }
        
    }
    
    public func subscriberIsAlreadySubscribed(subscriber: JABPanelChangeSubscriber) -> Bool {
        
        for i in 0..<subscribers.count {
            if subscribers[i] === subscriber {
                return true
            }
        }
        
        return false
    }
    
    public func notifySubscribersOfChange () {
        
        for subscriber in subscribers {
            subscriber.panelContentsDidChange(self)
        }
        
    }

}



public protocol JABPanelDelegate: class {
    func panelWasTapped(panel: JABPanel)
}

public protocol JABPanelChangeSubscriber: class {
    func panelContentsDidChange(panel: JABPanel)
}



// MARK:
// MARK: Equatable
// MARK:

public func == (lhs: JABPanel, rhs: JABPanel) -> Bool {
    return lhs === rhs
}

