//
//  JABView.swift
//  Party Hop
//
//  Created by Jeremy Bannister on 4/10/15.
//  Copyright (c) 2015 Bard App Team. All rights reserved.
//

import Foundation
import UIKit

public var defaultAnimationDuration = 0.25

public class JABView: UIView, GlobalVariablesInitializationNotificationSubscriber {
    
    
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Override
    override public var frame: CGRect {
        didSet {
            var scaled = false
            
            if ( (self.frame.size.width != oldValue.size.width) || (self.frame.size.height != oldValue.size.height) ) {
                scaled = true
            }
            
            if scaled {
                notificationLayer.frame = relativeFrame
                updateAllUI()
            }
        }
    }
    
    
    // MARK: Notification Layer
    public var notificationLayer = UIView()
    
    
    
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public init () {
        
        super.init(frame:CGRectZero)
        
        addSubview(notificationLayer)
        notificationLayer.frame = relativeFrame
        undimNotificationLayer()
        
        if !globalVariablesInitialized {
            globalVariableInitializationNotificationSubscribers.append(self)
        } else {
            globalVariablesWereInitialized()
        }
        
        addAllUI()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func globalVariablesWereInitialized() {
        
    }
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Override
    // MARK:
    
    override public func addSubview(view: UIView) {
        super.addSubview(view)
        bringSubviewToFront(notificationLayer)
    }
    
    
    // MARK:
    // MARK: Notifications
    // MARK:
    
    public func dimNotificationLayer () {
        notificationLayer.backgroundColor = UIColor(white: 0, alpha: 0.6)
        notificationLayer.userInteractionEnabled = true
    }
    
    public func undimNotificationLayer () {
        notificationLayer.backgroundColor = UIColor(white: 0, alpha: 0)
        notificationLayer.userInteractionEnabled = false
    }
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    public func addAllUI () {
        
    }
    
    public func updateAllUI () {
        
    }
    
    public func updateParameters () {
        
    }
    
    public func animatedUpdate () {
        animatedUpdate(.CurveEaseInOut)
    }
    
    public func animatedUpdate (options: UIViewAnimationOptions) {
        animatedUpdate(defaultAnimationDuration, options: options)
    }
    
    public func animatedUpdate (duration: NSTimeInterval, options: UIViewAnimationOptions) {
        animatedUpdate(duration: duration, options: options) { (Bool) -> () in
            
        }
    }
    
    public func animatedUpdate (duration: NSTimeInterval = defaultAnimationDuration, completion: (Bool) -> ()) {
        animatedUpdate(duration: duration, options: .CurveEaseInOut, completion: completion)
    }
    
    public func animatedUpdate (duration: NSTimeInterval = defaultAnimationDuration, options: UIViewAnimationOptions, completion: (Bool) -> ()) {
        
        UIView.animateWithDuration(duration, delay: 0, options: options, animations: { () -> Void in
            self.updateAllUI()
        }, completion: completion)
    }
    
    
    // MARK:
    // MARK: Keyboard
    // MARK:
    
    public func closeAllKeyboards () {
        
    }
    
    
}
