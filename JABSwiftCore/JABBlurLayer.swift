//
//  JABBlurLayer.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/25/17.
//  Copyright © 2017 Jeremy Bannister. All rights reserved.
//

import UIKit

public class JABBlurLayer: JABView {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    
    // MARK: State
    public var blurStyle: UIBlurEffectStyle = .extraLight
    public var blurFraction: CGFloat = 1.0
    public var blurAnimationCurve: UIViewAnimationCurve = .linear
    
    private var blurAnimator: Any?
    private var blurPauseTimer: Timer?
    private var isUnblurring = false
    
    // MARK: UI
    private let visualEffectView = UIVisualEffectView()
    
    // MARK: Parameters
    
    
    
    
    
    // **********************************************************************************************************************
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public init () {
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Should not be initializing from coder \(self)")
    }
    
    override public func globalVariablesWereInitialized() {
        
        updateParameters()
        
    }
    
    
    // MARK: Parameters
    override public func updateParameters() {
        
        
        if iPad {
            
        }
        
    }
    
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    
    // MARK: All
    override public func addAllUI() {
        
        addVisualEffectView()
        
    }
    
    override public func updateAllUI() {
        
        updateParameters()
        
        
        
        configureVisualEffectView()
        positionVisualEffectView()
        
    }
    
    
    // MARK: Adding
    private func addVisualEffectView () {
        addSubview(visualEffectView)
    }
    
    
    
    
    
    // MARK: Visual Effect View
    private func configureVisualEffectView () {
        let view = visualEffectView
    }
    
    private func positionVisualEffectView () {
        let view = visualEffectView
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
    
    
    // MARK: Blur
    public func blur (duration: TimeInterval = defaultAnimationDuration, completion: @escaping () -> () = { position in }) {
        if #available(iOS 10, *) {
            let animator = UIViewPropertyAnimator(duration: duration/Double(blurFraction), curve: .linear, animations: { self.visualEffectView.effect = UIBlurEffect(style: self.blurStyle) })
            blurAnimator = animator
            animator.addCompletion({ (position) in completion() })
            animator.startAnimation()
            blurPauseTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(pauseBlur), userInfo: nil, repeats: false)
        } else {
            UIView.animate(withDuration: duration, animations: { self.visualEffectView.effect = UIBlurEffect(style: self.blurStyle) }, completion: { (completed) in completion() })
        }
    }
    
    public func pauseBlur () {
        if #available(iOS 10, *) {
            guard let animator = blurAnimator as? UIViewPropertyAnimator else { return }
            if !isUnblurring { animator.stopAnimation(false) }
        }
    }
    
    /**
     
     Reverse the original blur animation
     
     - Author:
     Jeremy Bannister
     
     */
    
    public func unblur (duration: TimeInterval = defaultAnimationDuration, completion: @escaping () -> () = { position in }) {
        if #available(iOS 10, *) {
            blurPauseTimer?.invalidate()
            (blurAnimator as? UIViewPropertyAnimator)?.finishAnimation(at: .current)
            let animator = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: { self.visualEffectView.effect = nil })
            // In iOS 10, setting fractionComplete causes the animator to get stuck at this fraction, but in iOS 11 this is essential to prevent the animation starting from full blur
            if #available(iOS 11, *) { animator.fractionComplete = 1 - blurFraction }
            animator.addCompletion({ (position) in self.isUnblurring = false; completion() })
            isUnblurring = true
            animator.startAnimation()
        } else {
            UIView.animate(withDuration: duration, animations: { self.visualEffectView.effect = nil }, completion: { (completed) in completion() })
        }
    }
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
}

