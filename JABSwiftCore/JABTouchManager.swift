//
//  JABTouchManager.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/11/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit
import QuartzCore

open class JABTouchManager: NSObject, UIGestureRecognizerDelegate {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    
    // MARK: Delegate
    open var delegate: JABTouchManagerDelegate?
    
    // MARK: State
    open var touchDomain: UIView
    open var touchRecognizer: UILongPressGestureRecognizer?
    
    var initialTouchLocation = CGPoint() // Stores location from touchDidBegin
    var mostRecentTouchLocation = CGPoint() // Does not ever store end location, only intermediate locations
    var mostRecentTouchTime: TimeInterval = 0
    var xVelocityHistory: [CGFloat] = []
    var yVelocityHistory: [CGFloat] = []
    var deltaX: CGFloat = 0.0
    var deltaY: CGFloat = 0.0
    var previousDeltaX: CGFloat = 0.0
    var previousDeltaY: CGFloat = 0.0
    
    var methodCallNumber = 0
    
    
    
    public init(touchDomain: UIView) {
        
        self.touchDomain = touchDomain
        
        super.init()
        
        touchRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(JABTouchManager.touchDetected(_:)))
        guard let recognizer = touchRecognizer else { return }
        recognizer.delegate = self
        recognizer.minimumPressDuration = 0.0001
        recognizer.allowableMovement = 1000000
        touchDomain.addGestureRecognizer(recognizer)
    }
    
    
    
    
    open func touchDetected(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        if let verifiedStaticOnScreenView = staticOnScreenView {
            if let verifiedDelegate = delegate {
                
                let locationOnScreen = gestureRecognizer.location(in: verifiedStaticOnScreenView) // Get location in Static view
                var xVelocity: CGFloat = 0.0
                var yVelocity: CGFloat = 0.0
                
                var instantaneousXVelocity: CGFloat = 0.0
                var instantaneousYVelocity: CGFloat = 0.0
                
                let velocityAverageCount = 4
                
                
                methodCallNumber += 1
                
                if gestureRecognizer.state == UIGestureRecognizerState.began {
                    
                    initialTouchLocation = locationOnScreen
                    mostRecentTouchLocation = locationOnScreen
                    mostRecentTouchTime = CACurrentMediaTime()
                    previousDeltaX = 0.0
                    previousDeltaY = 0.0
                    
                    verifiedDelegate.touchDidBegin(self)
                    
                } else {
                    
                    deltaX = locationOnScreen.x - initialTouchLocation.x
                    deltaY = locationOnScreen.y - initialTouchLocation.y
                    
                    let xDistanceMoved = deltaX - previousDeltaX
                    let yDistanceMoved = deltaY - previousDeltaY
                    
                    
                    if gestureRecognizer.state == UIGestureRecognizerState.changed {
                        
                        if xDistanceMoved == 0 && yDistanceMoved == 0 { methodCallNumber -= 1; return }
                        
                        let xDisplacement = locationOnScreen.x - mostRecentTouchLocation.x
                        let yDisplacement = locationOnScreen.y - mostRecentTouchLocation.y
                        let timeInterval = CGFloat(CACurrentMediaTime() - mostRecentTouchTime)
                        
                        instantaneousXVelocity = xDisplacement/timeInterval
                        instantaneousYVelocity = yDisplacement/timeInterval
                        
                        xVelocityHistory.insert(instantaneousXVelocity, at: 0)
                        yVelocityHistory.insert(instantaneousYVelocity, at: 0)
                        
                        var count = 0
                        for v in xVelocityHistory {
                            if count < velocityAverageCount {
                                xVelocity += v
                            }
                            count += 1
                        }
                        
                        count = 0
                        for v in yVelocityHistory {
                            if count < velocityAverageCount {
                                yVelocity += v
                            }
                            count += 1
                        }
                        
                        xVelocity = xVelocity/CGFloat(velocityAverageCount)
                        yVelocity = yVelocity/CGFloat(velocityAverageCount)
                        
                        verifiedDelegate.touchDidChange(self, xDistance: xDistanceMoved, yDistance: yDistanceMoved, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
                        
                        previousDeltaX = deltaX
                        previousDeltaY = deltaY
                        
                        mostRecentTouchLocation = locationOnScreen
                        mostRecentTouchTime = CACurrentMediaTime()
                        
                        
                    } else {
                        
                        if gestureRecognizer.state == UIGestureRecognizerState.ended {
                            
                            let xDisplacement = locationOnScreen.x - mostRecentTouchLocation.x
                            let yDisplacement = locationOnScreen.y - mostRecentTouchLocation.y
                            let timeInterval = CGFloat(CACurrentMediaTime() - mostRecentTouchTime)
                            
                            instantaneousXVelocity = xDisplacement/timeInterval
                            instantaneousYVelocity = yDisplacement/timeInterval
                            
                            // Record the velocity
                            xVelocityHistory.insert(instantaneousXVelocity, at: 0)
                            yVelocityHistory.insert(instantaneousYVelocity, at: 0)
                            
                            // Average recent velocities for return value
                            var count = 0
                            for v in xVelocityHistory {
                                if count < velocityAverageCount {
                                    xVelocity += v
                                }
                                count += 1
                            }
                            
                            count = 0
                            for v in yVelocityHistory {
                                if count < velocityAverageCount {
                                    yVelocity += v
                                }
                                count += 1
                            }
                            
                            xVelocity = xVelocity/CGFloat(velocityAverageCount)
                            yVelocity = yVelocity/CGFloat(velocityAverageCount)
                            
                            verifiedDelegate.touchDidEnd(self, xDistance: xDistanceMoved, yDistance: yDistanceMoved, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
                            
                            mostRecentTouchLocation = CGPoint()
                            xVelocityHistory = []
                            yVelocityHistory = []
                            
                        } else if gestureRecognizer.state == UIGestureRecognizerState.cancelled {
                            
                            let xDisplacement = locationOnScreen.x - mostRecentTouchLocation.x
                            let yDisplacement = locationOnScreen.y - mostRecentTouchLocation.y
                            let timeInterval = CGFloat(CACurrentMediaTime() - mostRecentTouchTime)
                            
                            instantaneousXVelocity = xDisplacement/timeInterval
                            instantaneousYVelocity = yDisplacement/timeInterval
                            
                            // Record the velocity
                            xVelocityHistory.insert(instantaneousXVelocity, at: 0)
                            yVelocityHistory.insert(instantaneousYVelocity, at: 0)
                            
                            // Average recent velocities for return value
                            var count = 0
                            for v in xVelocityHistory {
                                if count < velocityAverageCount {
                                    xVelocity += v
                                }
                                count += 1
                            }
                            
                            count = 0
                            for v in yVelocityHistory {
                                if count < velocityAverageCount {
                                    yVelocity += v
                                }
                                count += 1
                            }
                            
                            xVelocity = xVelocity/CGFloat(velocityAverageCount)
                            yVelocity = yVelocity/CGFloat(velocityAverageCount)
                            
                            verifiedDelegate.touchDidCancel(self, xDistance: xDistanceMoved, yDistance: yDistanceMoved, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
                            
                            mostRecentTouchLocation = CGPoint()
                            
                        }
                        
                        
                        methodCallNumber = 0
                        previousDeltaX = 0
                        previousDeltaY = 0
                        
                        
                    }
                }
                
            }
        } else {
            print("Trying to detect touch before static on screen view was set", terminator: "")
        }
        
    }
    
    
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Gesture Recognizer
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        
        if let blockingViews = delegate?.blockingViews {
            for blockingView in blockingViews {
                
                if Toolkit.rectContainsPoint(blockingView.bounds, point: touch.location(in: blockingView)) {
                    return false
                }
                
            }
        }
        
        return true
        
    }
    
    open func cancelTouch () {
        touchRecognizer?.isEnabled = false
        touchRecognizer?.isEnabled = true
    }
    
    
    
}


// MARK:
// MARK: Delegate Protocol
// MARK:

public protocol JABTouchManagerDelegate {
    
    var blockingViews: [UIView] { get }
    
    func touchDidBegin (_ touchManager: JABTouchManager)
    func touchDidChange (_ touchManager: JABTouchManager, xDistance:CGFloat, yDistance:CGFloat, xVelocity:CGFloat, yVelocity:CGFloat, methodCallNumber:Int)
    func touchDidEnd (_ touchManager: JABTouchManager, xDistance:CGFloat, yDistance:CGFloat, xVelocity:CGFloat, yVelocity:CGFloat, methodCallNumber:Int)
    func touchDidCancel (_ touchManager: JABTouchManager, xDistance:CGFloat, yDistance:CGFloat, xVelocity:CGFloat, yVelocity:CGFloat, methodCallNumber:Int)
    
}
