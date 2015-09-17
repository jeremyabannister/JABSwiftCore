//
//  JABApplicationRoot.swift
//  Party Hop
//
//  Created by Jeremy Bannister on 4/10/15.
//  Copyright (c) 2015 Bard App Team. All rights reserved.
//

import Foundation

public class JABApplicationRoot: JABView, JABTouchableViewDelegate, JABLocationTesterDelegate {
    
    
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    override public var frame: CGRect {
        didSet {
            notificationLayer.frame = relativeFrame
            updateAllUI()
        }
    }
    
    // MARK: State
    
    // MARK: UI
    public var notificationLayer = JABTouchableView()
    private let locationTester = JABLocationTester()
    
    
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
    // MARK: Init
    // MARK:
    
    public override init () {
        super.init()
        
        staticOnScreenView = self
        initializeGlobalParameters()
        
        locationTester.locationTesterDelegate = self
        
        addSubview(notificationLayer)
        notificationLayer.delegate = self
        notificationLayer.frame = relativeFrame
        undimNotificationLayer()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init()
    }
    
    
    // MARK:
    // MARK: Notifications
    // MARK:
    
    public func dimNotificationLayer () {
        notificationLayer.backgroundColor = UIColor(white: 0, alpha: 0.4)
        notificationLayer.userInteractionEnabled = true
    }
    
    public func undimNotificationLayer () {
        notificationLayer.backgroundColor = UIColor(white: 0, alpha: 0)
        notificationLayer.userInteractionEnabled = false
    }
    
    
    // MARK:
    // MARK: Debug
    // MARK:
    
    public func launchLocationTesterAfterDelay (delay: NSTimeInterval) {
        
        NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: "launchLocationTester", userInfo: nil, repeats: false)
        
    }
    
    public func launchLocationTester () {
        
        locationTester.frame = relativeFrame
        addSubview(locationTester)
        
    }
    
    public func cancelLocationTester () {
        
        locationTester.removeFromSuperview()
        
    }
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Touchable View
    public func touchableViewTouchDidBegin(touchableView: JABTouchableView, gestureRecognizer: UIGestureRecognizer) {
        
    }
    
    public func touchableViewTouchDidChange(touchableView: JABTouchableView, gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
    }
    
    public func touchableViewTouchDidEnd(touchableView: JABTouchableView, gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
    }
    
    public func touchableViewTouchDidCancel(touchableView: JABTouchableView, gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
    }
    
    // MARK: Location Tester
    public func locationTesterDelegateDidCancel() {
        cancelLocationTester()
    }
    
    
}
