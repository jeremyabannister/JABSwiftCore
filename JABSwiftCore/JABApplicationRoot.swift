//
//  JABApplicationRoot.swift
//  Party Hop
//
//  Created by Jeremy Bannister on 4/10/15.
//  Copyright (c) 2015 Bard App Team. All rights reserved.
//

import Foundation

open class JABApplicationRoot: JABView, JABTouchableViewDelegate, JABLocationTesterDelegate {
    
    
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: State
    
    // MARK: UI
    open var notificationLayer = JABTouchableView()
    fileprivate let locationTester = JABLocationTester()
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Override
    // MARK:
    
    override open func addSubview(_ view: UIView) {
        super.addSubview(view)
        bringSubview(toFront: notificationLayer)
    }

    
    // MARK:
    // MARK: Init
    // MARK:
    
    public override init (frame: CGRect = CGRect.zero, shouldAddAllUI: Bool = true) {
        super.init(frame: frame, shouldAddAllUI: shouldAddAllUI)
        
        staticOnScreenView = self
        initializeGlobalParameters()
        
        locationTester.locationTesterDelegate = self
        
        addSubview(notificationLayer)
        notificationLayer.delegate = self
        notificationLayer.frame = relativeFrame
        undimNotificationLayer()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK:
    // MARK: Notifications
    // MARK:
    
    open func dimNotificationLayer () {
        notificationLayer.backgroundColor = UIColor(white: 0, alpha: 0.4)
        notificationLayer.isUserInteractionEnabled = true
    }
    
    open func undimNotificationLayer () {
        notificationLayer.backgroundColor = UIColor(white: 0, alpha: 0)
        notificationLayer.isUserInteractionEnabled = false
    }
    
    
    // MARK:
    // MARK: Debug
    // MARK:
    
    open func launchLocationTesterAfterDelay (_ delay: TimeInterval) {
        
        Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(JABApplicationRoot.launchLocationTester), userInfo: nil, repeats: false)
        
    }
    
    open func launchLocationTester () {
        
        locationTester.frame = relativeFrame
        addSubview(locationTester)
        
    }
    
    open func cancelLocationTester () {
        
        locationTester.removeFromSuperview()
        
    }
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Touchable View
    open func touchableViewTouchDidBegin(_ touchableView: JABTouchableView) {
        
    }
    
    open func touchableViewTouchDidChange(_ touchableView: JABTouchableView, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
    }
    
    open func touchableViewTouchDidEnd(_ touchableView: JABTouchableView, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
    }
    
    open func touchableViewTouchDidCancel(_ touchableView: JABTouchableView, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
    }
    
    // MARK: Location Tester
    open func locationTesterDelegateDidCancel() {
        cancelLocationTester()
    }
    
    
}
