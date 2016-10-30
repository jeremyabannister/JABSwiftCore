//
//  JABLocationTester.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 8/2/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

open class JABLocationTester: JABTouchableView {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Override
    override open var frame: CGRect {
        didSet {
            if frame.size.width != oldValue.size.width || frame.size.height != oldValue.size.height {
                location = CGPoint(x: width/2, y: height/2)
                updateAllUI()
            }
        }
    }
    
    // MARK: Delegate
    open var locationTesterDelegate: JABLocationTesterDelegate?
    
    // MARK: State
    // Public
    open var color = blackColor
    
    // Private
    fileprivate var location = CGPoint()
    fileprivate var mediaTimeOfLastTap = CACurrentMediaTime()
    
    // MARK: UI
    fileprivate let horizontalLine = UIView()
    fileprivate let verticalLine = UIView()
    
    // MARK: Parameters
    // Most parameters are expressed as a fraction of the width of the view. This is done so that if the view is animated to a different frame the subviews will adjust accordingly, which would not happen if all spacing was defined statically
    
    
    
    
    // **********************************************************************************************************************
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public override init () {
        super.init()
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init()
        print("Should not be initializing from coder \(self)")
    }
    
    override open func globalVariablesWereInitialized() {
        
        if iPad {
            
        }
    }
    
    
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    
    // MARK: All
    override open func addAllUI() {
        
        addHorizontalLine()
        addVerticalLine()
        
    }
    
    override open func updateAllUI() {
        
        configureHorizontalLine()
        positionHorizontalLine()
        
        configureVerticalLine()
        positionVerticalLine()
        
    }
    
    
    
    // MARK: Adding
    fileprivate func addHorizontalLine () {
        addSubview(horizontalLine)
    }
    
    fileprivate func addVerticalLine () {
        addSubview(verticalLine)
    }
    
    
    
    // MARK: Horizontal Line
    fileprivate func configureHorizontalLine () {
        
        horizontalLine.backgroundColor = color
        
    }
    
    fileprivate func positionHorizontalLine () {
        
        var newFrame = CGRect.zero
        
        newFrame.size.width = width
        newFrame.size.height = 0.5
        
        newFrame.origin.x = (width - newFrame.size.width)/2
        newFrame.origin.y = location.y - (newFrame.size.height/2)
        
        horizontalLine.frame = newFrame
        
    }
    
    
    // MARK: Vertical Line
    fileprivate func configureVerticalLine () {
        
        verticalLine.backgroundColor = color
        
    }
    
    fileprivate func positionVerticalLine () {
        
        var newFrame = CGRect.zero
        
        newFrame.size.width = 0.5
        newFrame.size.height = height
        
        newFrame.origin.x = location.x - (newFrame.size.width/2)
        newFrame.origin.y = (height - newFrame.size.height)/2
        
        verticalLine.frame = newFrame
        
    }
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Touch Manager
    override open func touchDidBegin(_ gestureRecognizer: UIGestureRecognizer) {
        
        location = gestureRecognizer.location(in: self)
        print("(\(location.x), \(location.y))")
        animatedUpdate()
        
    }
    
    override open func touchDidChange(_ gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        location = gestureRecognizer.location(in: self)
        print("(\(location.x), \(location.y))")
        updateAllUI()
        
    }
    
    override open func touchDidEnd(_ gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        location = gestureRecognizer.location(in: self)
        print("(\(location.x), \(location.y))")
        updateAllUI()
        
        
        if CACurrentMediaTime() - mediaTimeOfLastTap < 0.2 {
            locationTesterDelegate?.locationTesterDelegateDidCancel()
        } else {
            mediaTimeOfLastTap = CACurrentMediaTime()
        }
        
    }
    
    override open func touchDidCancel(_ gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        location = gestureRecognizer.location(in: self)
        print("(\(location.x), \(location.y))")
        updateAllUI()
        
    }
    
}


public protocol JABLocationTesterDelegate {
    func locationTesterDelegateDidCancel ()
}
