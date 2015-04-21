//
//  JABTouchManager.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/11/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit
import QuartzCore

public class JABTouchManager: NSObject, UIGestureRecognizerDelegate {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    
    // MARK: Delegate
    var delegate: JABTouchManagerDelegate?
    
    // MARK: State
    public var parentView: UIView?
    public var touchDomain: UIView
    
    var touchRecognizer: UILongPressGestureRecognizer?
    
    var initialTouchLocation = CGPoint() // Stores location from touchDidBegin
    var mostRecentTouchLocation = CGPoint() // Does not ever store end location, only intermediate locations
    var mostRecentTouchTime: NSTimeInterval = 0
    var xVelocityHistory: [CGFloat] = []
    var yVelocityHistory: [CGFloat] = []
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
            
            let location = gestureRecognizer.locationInView(touchDomain) // Get the location in the associated TouchableView
            let locationInParentView = gestureRecognizer.locationInView(parentView) // Get location in parent view
            var xVelocity: CGFloat = 0.0
            var yVelocity: CGFloat = 0.0
            
            var instantaneousXVelocity: CGFloat = 0.0
            var instantaneousYVelocity: CGFloat = 0.0
            
            let velocityAverageCount = 4
            
            
            methodCallNumber++
            
            if gestureRecognizer.state == UIGestureRecognizerState.Began {
                
                initialTouchLocation = location
                mostRecentTouchLocation = location
                previousDeltaX = 0.0
                previousDeltaY = 0.0
                
                verifiedDelegate.touchDidBegin(location, locationInParentView: locationInParentView)
                
            } else {
                
                deltaX = location.x - initialTouchLocation.x
                deltaY = location.y - initialTouchLocation.y
                
                var xDistanceMoved = deltaX - previousDeltaX
                var yDistanceMoved = deltaY - previousDeltaY
                
                println("xDistance is \(xDistanceMoved) location.x = \(location.x)")
                
                if gestureRecognizer.state == UIGestureRecognizerState.Changed {
                    
                    let xDisplacement = location.x - mostRecentTouchLocation.x
                    let yDisplacement = location.y - mostRecentTouchLocation.y
                    let timeInterval = CGFloat(CACurrentMediaTime() - mostRecentTouchTime)
                    
                    instantaneousXVelocity = xDisplacement/timeInterval
                    instantaneousYVelocity = yDisplacement/timeInterval
                    
                    xVelocityHistory.append(instantaneousXVelocity)
                    yVelocityHistory.append(instantaneousYVelocity)
                    
                    var count = 0
                    for v in xVelocityHistory {
                        if count < velocityAverageCount {
                            xVelocity += v
                        }
                        count++
                    }
                    
                    count = 0
                    for v in yVelocityHistory {
                        if count < velocityAverageCount {
                            yVelocity += v
                        }
                        count++
                    }
                    
                    xVelocity = xVelocity/CGFloat(velocityAverageCount)
                    yVelocity = yVelocity/CGFloat(velocityAverageCount)
                    
                    
                    verifiedDelegate.touchDidChange(location, locationInParentView: locationInParentView, xDistance: xDistanceMoved, yDistance: yDistanceMoved, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
                    
                    previousDeltaX = deltaX
                    previousDeltaY = deltaY
                    
                    mostRecentTouchLocation = location
                    mostRecentTouchTime = CACurrentMediaTime()
                    
                    
                } else {
                    
                    if gestureRecognizer.state == UIGestureRecognizerState.Ended {
                        
                        let xDisplacement = location.x - mostRecentTouchLocation.x
                        let yDisplacement = location.y - mostRecentTouchLocation.y
                        let timeInterval = CGFloat(CACurrentMediaTime() - mostRecentTouchTime)
                        
                        instantaneousXVelocity = xDisplacement/timeInterval
                        instantaneousYVelocity = yDisplacement/timeInterval
                        
                        // Record the velocity
                        xVelocityHistory.append(instantaneousXVelocity)
                        yVelocityHistory.append(instantaneousYVelocity)
                        
                        // Average recent velocities for return value
                        var count = 0
                        for v in xVelocityHistory {
                            if count < velocityAverageCount {
                                xVelocity += v
                            }
                            count++
                        }
                        
                        count = 0
                        for v in yVelocityHistory {
                            if count < velocityAverageCount {
                                yVelocity += v
                            }
                            count++
                        }
                        
                        xVelocity = xVelocity/CGFloat(velocityAverageCount)
                        yVelocity = yVelocity/CGFloat(velocityAverageCount)
                        
                        
                        verifiedDelegate.touchDidEnd(location, locationInParentView: locationInParentView, xDistance: xDistanceMoved, yDistance: yDistanceMoved, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
                        
                        mostRecentTouchLocation = CGPoint()
                        xVelocityHistory = []
                        yVelocityHistory = []
                        
                    } else if gestureRecognizer.state == UIGestureRecognizerState.Cancelled {
                        
                        let xDisplacement = location.x - mostRecentTouchLocation.x
                        let yDisplacement = location.y - mostRecentTouchLocation.y
                        let timeInterval = CGFloat(CACurrentMediaTime() - mostRecentTouchTime)
                        
                        instantaneousXVelocity = xDisplacement/timeInterval
                        instantaneousYVelocity = yDisplacement/timeInterval
                        
                        // Record the velocity
                        xVelocityHistory.append(instantaneousXVelocity)
                        yVelocityHistory.append(instantaneousYVelocity)
                        
                        // Average recent velocities for return value
                        var count = 0
                        for v in xVelocityHistory {
                            if count < velocityAverageCount {
                                println("adding")
                                xVelocity += v
                            }
                            count++
                        }
                        
                        count = 0
                        for v in yVelocityHistory {
                            if count < velocityAverageCount {
                                yVelocity += v
                            }
                            count++
                        }
                        
                        xVelocity = xVelocity/CGFloat(velocityAverageCount)
                        yVelocity = yVelocity/CGFloat(velocityAverageCount)
                        
                        
                        verifiedDelegate.touchDidCancel(location, locationInParentView: locationInParentView, xDistance: xDistanceMoved, yDistance: yDistanceMoved, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
                        
                        mostRecentTouchLocation = CGPoint()
                        
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
    
    func touchDidBegin (locationInView:CGPoint, locationInParentView:CGPoint?)
    func touchDidChange (locationInView:CGPoint, locationInParentView:CGPoint?, xDistance:CGFloat, yDistance:CGFloat, xVelocity:CGFloat, yVelocity:CGFloat, methodCallNumber:Int)
    func touchDidEnd (locationInView:CGPoint, locationInParentView:CGPoint?, xDistance:CGFloat, yDistance:CGFloat, xVelocity:CGFloat, yVelocity:CGFloat, methodCallNumber:Int)
    func touchDidCancel (locationInView:CGPoint, locationInParentView:CGPoint?, xDistance:CGFloat, yDistance:CGFloat, xVelocity:CGFloat, yVelocity:CGFloat, methodCallNumber:Int)
    
}