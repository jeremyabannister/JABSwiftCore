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
    
    override public var frame: CGRect {
        didSet {
            var scaled = false
            
            if ( (self.frame.size.width != oldValue.size.width) || (self.frame.size.height != oldValue.size.height) ) {
                scaled = true
            }
            
            if scaled {
                updateAllUI()
            }
        }
    }
    
    
    
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public init () {
        
        super.init(frame:CGRectZero)
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
    // MARK: UI
    // MARK:
    
    public func addAllUI () {
        
    }
    
    public func updateAllUI () {
        
    }
    
    public func updateParameters () {
        
    }
    
    public func animatedUpdate () {
        animatedUpdate(defaultAnimationDuration)
    }
    
    public func animatedUpdate (duration: NSTimeInterval) {
        animatedUpdate(duration: duration, completion: { (Bool) -> () in
            
        })
    }
    
    public func animatedUpdate (duration: NSTimeInterval, options: UIViewAnimationOptions) {
        animatedUpdate(duration: duration, options: options) { (Bool) -> () in
            
        }
    }
    
    public func animatedUpdate (duration: NSTimeInterval = defaultAnimationDuration, completion: (Bool) -> ()) {
        UIView.animateWithDuration(duration, animations: { () -> () in
            self.updateAllUI()
        }, completion: completion)
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
