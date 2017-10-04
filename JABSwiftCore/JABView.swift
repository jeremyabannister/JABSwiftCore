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

/**
 JABView is the replacement for UIViewController. There are two important features of JABView which distinguish it from UIViewController:
 
 1. The first is that JABView is a subclass of UIView. This means that with JABView you can simply write `self.addSubview(mySubview)`, whereas with UIViewController you would need to explicitly reference the viewController's view by writing `self.view.addSubview(mySubview)`.
 
 1. The second distinguishing feature of JABView is the method `updateAllUI()` (and its animated counterpart, `animatedUpdate()`). This method is intended to be overridden by the subclass. Its job is to update all of the visual elements owned by this JABView to their correct state, according to all the variables which track the state of the app.
 */
open class JABView: UIView, GlobalVariablesInitializationNotificationSubscriber {
    
    // MARK: Static
    
    // Animated Update
    public static var isGeneratingAnimatedUpdate: Bool = false
    public static var animationDuration: TimeInterval = defaultAnimationDuration
    public static var animationTimingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    
    // Timing Functions
    public enum TimingFunction { case easeInOut, easeIn, easeOut, linear, custom(Float, Float, Float, Float) }
    public static func mediaTimingFunction (for timingFunction: TimingFunction) -> CAMediaTimingFunction {
        switch timingFunction {
        case .easeInOut:
            return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        case .easeIn:
            return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        case .easeOut:
            return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        case .linear:
            return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        case .custom(let one, let two, let three, let four):
            return CAMediaTimingFunction(controlPoints: one, two, three, four)
        }
    }
    
    
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
    
    //    open func animatedUpdate (duration: TimeInterval = defaultAnimationDuration, delay: TimeInterval = 0, options: UIViewAnimationOptions = .curveEaseInOut, completion: @escaping (Bool) -> () = {(completed) in }) {
    //
    //        UIView.animate(withDuration: duration, delay: delay, options: options, animations: { () -> Void in
    //            self.updateAllUI()
    //        }, completion: completion)
    //    }
    
    private func options (for timingFunction: TimingFunction) -> UIViewAnimationOptions {
        switch timingFunction {
        case .linear:
            return .curveLinear
        case .easeIn:
            return .curveEaseIn
        case .easeOut:
            return .curveEaseOut
        default:
            return .curveEaseInOut
        }
    }
    
    open func animatedUpdate (duration: TimeInterval = defaultAnimationDuration, timingFunction: TimingFunction = .easeInOut, completion: @escaping (Bool) -> () = { (completed) in }) {
        
        
        let oldDuration = JABView.animationDuration
        let oldTimingFunction = JABView.animationTimingFunction
        
        JABView.isGeneratingAnimatedUpdate = true
        JABView.animationDuration = duration
        JABView.animationTimingFunction = JABView.mediaTimingFunction(for: timingFunction)
        
        self.updateAllUI()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) { completion(true) }
        
        JABView.isGeneratingAnimatedUpdate = false
        JABView.animationDuration = oldDuration
        JABView.animationTimingFunction = oldTimingFunction
    }
    
    
    
    // MARK:
    // MARK: Keyboard
    // MARK:
    
    open func closeAllKeyboards () {
        
    }
    
    
}

