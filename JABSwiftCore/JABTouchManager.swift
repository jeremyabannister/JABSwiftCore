//
//  JABTouchManager.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/11/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public class JABTouchManager: NSObject, UIGestureRecognizerDelegate {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    
    // MARK: Delegate
    var delegate: JABTouchManagerDelegate?
    
    // MARK: Touch
    public var parentView: UIView?
    public var touchDomain: UIView
    var touchRecognizer: UILongPressGestureRecognizer?
    
    var initialTouchLocation = CGPoint(x: 0, y: 0)
    
    var deltaX: CGFloat = 0.0
    var deltaY: CGFloat = 0.0
    var previousDeltaX: CGFloat = 0.0
    var previousDeltaY: CGFloat = 0.0
    
    var methodCallNumber = 0
    
    
    
    public init(newTouchDomain: UIView) {
        touchDomain = newTouchDomain
        super.init()
        
        touchRecognizer = UILongPressGestureRecognizer(target: self, action: "touchDetected:")
        touchRecognizer?.delegate = self
        touchRecognizer?.minimumPressDuration = 0.0001
        touchRecognizer?.allowableMovement = 1000000
        if touchRecognizer != nil {
            touchDomain.addGestureRecognizer(touchRecognizer!)
        }
    }
    
    
    
    
    public func touchDetected(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if let verifiedDelegate = delegate {
            
            let location = gestureRecognizer.locationInView(parentView)
            println(location)
            println("parent view is \(parentView)")
            let locationInTouchDomain = gestureRecognizer.locationInView(touchDomain)
            
            methodCallNumber++
            
            if gestureRecognizer.state == UIGestureRecognizerState.Began {
                
                initialTouchLocation = location
                previousDeltaX = 0.0
                previousDeltaY = 0.0
                
                verifiedDelegate.touchDidBegin(location, locationInView: locationInTouchDomain)
                
            } else {
                
                deltaX = location.x - initialTouchLocation.x
                deltaY = location.y - initialTouchLocation.y
                
                var xDistanceMoved = deltaX - previousDeltaX
                var yDistanceMoved = deltaY - previousDeltaY
                
                if gestureRecognizer.state == UIGestureRecognizerState.Changed {
                    
                    verifiedDelegate.touchDidChange(location, locationInView: locationInTouchDomain, xDistance: xDistanceMoved, yDistance: yDistanceMoved, methodCallNumber: methodCallNumber)
                    
                    previousDeltaX = deltaX
                    previousDeltaY = deltaY
                    
                    
                } else {
                    
                    if gestureRecognizer.state == UIGestureRecognizerState.Ended {
                        
                        verifiedDelegate.touchDidEnd(location, locationInView: locationInTouchDomain, xDistance: xDistanceMoved, yDistance: yDistanceMoved, methodCallNumber: methodCallNumber)
                        
                    } else if gestureRecognizer.state == UIGestureRecognizerState.Cancelled {
                        
                        verifiedDelegate.touchDidCancel(location, locationInView: locationInTouchDomain, xDistance: xDistanceMoved, yDistance: yDistanceMoved, methodCallNumber: methodCallNumber)
                        
                    }
                    
                    
                    methodCallNumber = 0
                    previousDeltaX = 0
                    previousDeltaY = 0
                    
                    
                }
            }
            
        }
    }
    
    
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Gesture Recognizer
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        
        if let blockingViews = delegate?.blockingViews {
            for blockingView in blockingViews {
                
                if Toolkit.rectContainsPoint(blockingView.relativeFrame, point: touch.locationInView(blockingView)) {
                    return false
                }
                
            }
        }
        
        return true
        
    }
    
    
    
    
}


// MARK:
// MARK: Delegate Protocol
// MARK:

public protocol JABTouchManagerDelegate {
    
    var blockingViews: [UIView] { get }
    
    func touchDidBegin (locationInParentView:CGPoint?, locationInView:CGPoint)
    func touchDidChange (locationInParentView:CGPoint?, locationInView:CGPoint, xDistance:CGFloat, yDistance:CGFloat, methodCallNumber:Int)
    func touchDidEnd (locationInParentView:CGPoint?, locationInView:CGPoint, xDistance:CGFloat, yDistance:CGFloat, methodCallNumber:Int)
    func touchDidCancel (locationInParentView:CGPoint?, locationInView:CGPoint, xDistance:CGFloat, yDistance:CGFloat, methodCallNumber:Int)
    
}