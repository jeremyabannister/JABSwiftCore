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
    
    public init (frame: CGRect = CGRect.zero, shouldAddAllUI: Bool = true) {
        
        super.init(frame: frame)
        
        if !globalVariablesInitialized {
            globalVariableInitializationNotificationSubscribers.append(self)
        } else {
            globalVariablesWereInitialized()
        }
        
        if shouldAddAllUI { addAllUI() }
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
    
    open func animatedUpdate (duration: TimeInterval = defaultAnimationDuration, delay: TimeInterval = 0, options: UIViewAnimationOptions = .curveEaseInOut, completion: @escaping (Bool) -> () = {(completed) in }) {
        
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: { () -> Void in
            self.updateAllUI()
        }, completion: completion)
    }
    
    
    // MARK:
    // MARK: Keyboard
    // MARK:
    
    open func closeAllKeyboards () {
        
    }
    
    
}
