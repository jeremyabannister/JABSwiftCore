//
//  JABTouchableView.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/11/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public class JABTouchableView: JABView, JABTouchManagerDelegate {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    public var delegate: JABTouchableViewDelegate?
    
    
    // MARK:
    // MARK: Touch Recognition System
    // MARK:
    public var touchManager: JABTouchManager?
    public var blockingViews: [UIView] = []
    
    
    // **********************************************************************************************************************
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public override init () {
        super.init()
        
        createTouchRecognitionSystem()
    }
    
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    public func createTouchRecognitionSystem () {
        
        touchManager = JABTouchManager(newTouchDomain: self)
        touchManager?.delegate = self
        
    }
    
    public func blockWithView(blockingView: UIView) {
        
        if !contains(blockingViews, blockingView) {
            blockingViews.append(blockingView)
        }
    }
    
    
    public func unblockWithView(blockingView: UIView) {
        if contains(blockingViews, blockingView) {
            Toolkit.removeObject(blockingView, fromArray: &blockingViews)
        }
    }
    
    
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Touch Manager
    public func touchDidBegin(locationInView: CGPoint, locationOnScreen: CGPoint) {
        delegate?.touchableViewTouchDidBegin(self, locationOnScreen: locationOnScreen, locationInView: locationInView)
    }
    
    public func touchDidChange(locationInView: CGPoint, locationOnScreen: CGPoint, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        delegate?.touchableViewTouchDidChange(self, locationOnScreen: locationOnScreen, locationInView: locationInView, xDistance: xDistance, yDistance: yDistance, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
    }
    
    public func touchDidEnd(locationInView: CGPoint, locationOnScreen: CGPoint, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        delegate?.touchableViewTouchDidEnd(self, locationOnScreen: locationOnScreen, locationInView: locationInView, xDistance: xDistance, yDistance: yDistance, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
    }
    
    public func touchDidCancel(locationInView: CGPoint, locationOnScreen: CGPoint, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        delegate?.touchableViewTouchDidCancel(self, locationOnScreen: locationOnScreen, locationInView: locationInView, xDistance: xDistance, yDistance: yDistance, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
    }
    
    
    
    
    
}



public protocol JABTouchableViewDelegate {
    
    func touchableViewTouchDidBegin(touchableView: JABTouchableView, locationOnScreen:CGPoint, locationInView:CGPoint)
    func touchableViewTouchDidChange(touchableView: JABTouchableView, locationOnScreen:CGPoint, locationInView:CGPoint, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int)
    func touchableViewTouchDidEnd(touchableView: JABTouchableView, locationOnScreen:CGPoint, locationInView:CGPoint, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int)
    func touchableViewTouchDidCancel(touchableView: JABTouchableView, locationOnScreen:CGPoint, locationInView:CGPoint, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int)
    
    
}