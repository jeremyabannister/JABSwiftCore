//
//  JABLocationTester.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 8/2/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public class JABLocationTester: JABTouchableView {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Override
    override public var frame: CGRect {
        didSet {
            if frame.size.width != oldValue.size.width || frame.size.height != oldValue.size.height {
                location = CGPoint(x: width/2, y: height/2)
                updateAllUI()
            }
        }
    }
    
    // MARK: Delegate
    public var locationTesterDelegate: JABLocationTesterDelegate?
    
    // MARK: State
    // Public
    public var color = blackColor
    
    // Private
    private var location = CGPoint()
    private var mediaTimeOfLastTap = CACurrentMediaTime()
    
    // MARK: UI
    private let horizontalLine = UIView()
    private let verticalLine = UIView()
    
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
    
    override public func globalVariablesWereInitialized() {
        
        if iPad {
            
        }
    }
    
    
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    
    // MARK: All
    override public func addAllUI() {
        
        addHorizontalLine()
        addVerticalLine()
        
    }
    
    override public func updateAllUI() {
        
        configureHorizontalLine()
        positionHorizontalLine()
        
        configureVerticalLine()
        positionVerticalLine()
        
    }
    
    
    
    // MARK: Adding
    private func addHorizontalLine () {
        addSubview(horizontalLine)
    }
    
    private func addVerticalLine () {
        addSubview(verticalLine)
    }
    
    
    
    // MARK: Horizontal Line
    private func configureHorizontalLine () {
        
        horizontalLine.backgroundColor = color
        
    }
    
    private func positionHorizontalLine () {
        
        var newFrame = CGRectZero
        
        newFrame.size.width = width
        newFrame.size.height = 0.5
        
        newFrame.origin.x = (width - newFrame.size.width)/2
        newFrame.origin.y = location.y - (newFrame.size.height/2)
        
        horizontalLine.frame = newFrame
        
    }
    
    
    // MARK: Vertical Line
    private func configureVerticalLine () {
        
        verticalLine.backgroundColor = color
        
    }
    
    private func positionVerticalLine () {
        
        var newFrame = CGRectZero
        
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
    override public func touchDidBegin(gestureRecognizer: UIGestureRecognizer) {
        
        location = gestureRecognizer.locationInView(self)
        print("(\(location.x), \(location.y))")
        animatedUpdate()
        
    }
    
    override public func touchDidChange(gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        location = gestureRecognizer.locationInView(self)
        print("(\(location.x), \(location.y))")
        updateAllUI()
        
    }
    
    override public func touchDidEnd(gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        location = gestureRecognizer.locationInView(self)
        print("(\(location.x), \(location.y))")
        updateAllUI()
        
        
        if CACurrentMediaTime() - mediaTimeOfLastTap < 0.2 {
            locationTesterDelegate?.locationTesterDelegateDidCancel()
        } else {
            mediaTimeOfLastTap = CACurrentMediaTime()
        }
        
    }
    
    override public func touchDidCancel(gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        location = gestureRecognizer.locationInView(self)
        print("(\(location.x), \(location.y))")
        updateAllUI()
        
    }
    
}


public protocol JABLocationTesterDelegate {
    func locationTesterDelegateDidCancel ()
}
