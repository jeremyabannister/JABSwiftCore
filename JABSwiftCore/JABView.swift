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
open class JABView: UIView {
  
  // MARK: Static
  
  // Animated Update
  public static var isGeneratingAnimatedUpdate: Bool = false
  /// This unfortunately cannot be named "animationDuration" because it conflicts with an Objective-C setter on UIView
  public static var animateDuration: TimeInterval = defaultAnimationDuration
  public static var animationTimingFunction: TimingFunction = .easeInOut
  
  
  // MARK:
  // MARK: Properties
  // MARK:
  
  
  
  // MARK:
  // MARK: Init
  // MARK:
  
  public init (frame: CGRect = CGRect.zero, shouldAddAllUI: Bool = true) {
    
    super.init(frame: frame)
    
    if shouldAddAllUI { addAllUI() }
  }
  
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
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
  
  open func animate (_ updateCode: () -> (), duration: TimeInterval = defaultAnimationDuration, timingFunction: TimingFunction = .easeInOut, completion: @escaping (Bool) -> () = { (completed) in }) {
    let oldDuration = JABView.animateDuration
    let oldTimingFunction = JABView.animationTimingFunction
    
    JABView.isGeneratingAnimatedUpdate = true
    JABView.animateDuration = duration
    JABView.animationTimingFunction = timingFunction
    
    updateCode()
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) { completion(true) }
    
    JABView.isGeneratingAnimatedUpdate = false
    JABView.animateDuration = oldDuration
    JABView.animationTimingFunction = oldTimingFunction
  }
  
  
  open func animatedUpdate (duration: TimeInterval = defaultAnimationDuration, timingFunction: TimingFunction = .easeInOut, completion: @escaping (Bool) -> () = { (completed) in }) {
    animate({ self.updateAllUI() }, duration: duration, timingFunction: timingFunction, completion: completion)
  }
  
  
  
  // MARK:
  // MARK: Keyboard
  // MARK:
  
  open func closeAllKeyboards () {
    
  }
  
  
}

