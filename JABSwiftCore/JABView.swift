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

open class JABView: UIView, GlobalVariablesInitializationNotificationSubscriber {
    
    
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    
    // MARK:
    // MARK: Init
    // MARK:
    
    override public init (frame: CGRect = CGRect.zero) {
        
        super.init(frame: frame)
        
        if !globalVariablesInitialized {
            globalVariableInitializationNotificationSubscribers.append(self)
        } else {
            globalVariablesWereInitialized()
        }
        
        addAllUI()
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func globalVariablesWereInitialized() {
        
    }
    
    // MARK:
    // MARK: Methods
    // MARK:
        
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    open func addAllUI () {
        
    }
    
    open func updateAllUI () {
        
    }
    
    open func updateParameters () {
        
    }
    
    open func animatedUpdate () {
        animatedUpdate(UIViewAnimationOptions())
    }
    
    open func animatedUpdate (_ options: UIViewAnimationOptions) {
        animatedUpdate(defaultAnimationDuration, options: options)
    }
    
    open func animatedUpdate (_ duration: TimeInterval, options: UIViewAnimationOptions) {
        animatedUpdate(duration, options: options) { (Bool) -> () in
            
        }
    }
    
    open func animatedUpdate (_ duration: TimeInterval = defaultAnimationDuration, completion: @escaping (Bool) -> ()) {
        animatedUpdate(duration, options: UIViewAnimationOptions(), completion: completion)
    }
    
    open func animatedUpdate (_ duration: TimeInterval = defaultAnimationDuration, options: UIViewAnimationOptions, completion: @escaping (Bool) -> ()) {
        
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: { () -> Void in
            self.updateAllUI()
        }, completion: completion)
    }
    
    
    // MARK:
    // MARK: Keyboard
    // MARK:
    
    open func closeAllKeyboards () {
        
    }
    
    
}
