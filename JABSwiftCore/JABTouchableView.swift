//
//  JABTouchableView.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/11/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

open class JABTouchableView: JABView, JABTouchManagerDelegate {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    open var delegate: JABTouchableViewDelegate?
    
    
    // MARK:
    // MARK: Touch Recognition System
    // MARK:
    open var touchManager: JABTouchManager?
    open var blockingViews: [UIView] = []
    
    
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
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    open func createTouchRecognitionSystem () {
        
        touchManager = JABTouchManager(newTouchDomain: self)
        touchManager?.delegate = self
        
    }
    
    open func blockWithView(_ blockingView: UIView) {
        
        if !blockingViews.contains(blockingView) {
            blockingViews.append(blockingView)
        }
        
    }
    
    
    
    open func unblockWithView(_ blockingView: UIView) {
        
        if blockingViews.contains(blockingView) {
            Toolkit.removeObject(blockingView, fromArray: &blockingViews)
        }
    }
    
    
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Touch Manager
    open func touchDidBegin(_ gestureRecognizer: UIGestureRecognizer) {
        delegate?.touchableViewTouchDidBegin(self, gestureRecognizer: gestureRecognizer)
    }
    
    open func touchDidChange(_ gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        delegate?.touchableViewTouchDidChange(self, gestureRecognizer: gestureRecognizer, xDistance: xDistance, yDistance: yDistance, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
    }
    
    open func touchDidEnd(_ gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        delegate?.touchableViewTouchDidEnd(self, gestureRecognizer: gestureRecognizer, xDistance: xDistance, yDistance: yDistance, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
    }
    
    open func touchDidCancel(_ gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        delegate?.touchableViewTouchDidCancel(self, gestureRecognizer: gestureRecognizer, xDistance: xDistance, yDistance: yDistance, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
    }
    
    
    
    
    
}



public protocol JABTouchableViewDelegate {
    
    func touchableViewTouchDidBegin(_ touchableView: JABTouchableView, gestureRecognizer: UIGestureRecognizer)
    func touchableViewTouchDidChange(_ touchableView: JABTouchableView, gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int)
    func touchableViewTouchDidEnd(_ touchableView: JABTouchableView, gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int)
    func touchableViewTouchDidCancel(_ touchableView: JABTouchableView, gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int)
    
    
}
