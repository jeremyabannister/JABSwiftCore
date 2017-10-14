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
    
    override public init (frame: CGRect = CGRect.zero, shouldAddAllUI: Bool = true) {
        super.init(frame: frame, shouldAddAllUI: shouldAddAllUI)
        createTouchRecognitionSystem()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    open func createTouchRecognitionSystem () {
        
        touchManager = JABTouchManager(touchDomain: self)
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
    open func touchDidBegin(_ touchManager: JABTouchManager) {
        delegate?.touchableViewTouchDidBegin(self)
    }
    
    open func touchDidChange(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        delegate?.touchableViewTouchDidChange(self, xDistance: xDistance, yDistance: yDistance, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
    }
    
    open func touchDidEnd(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        delegate?.touchableViewTouchDidEnd(self, xDistance: xDistance, yDistance: yDistance, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
    }
    
    open func touchDidCancel(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        delegate?.touchableViewTouchDidCancel(self, xDistance: xDistance, yDistance: yDistance, xVelocity: xVelocity, yVelocity: yVelocity, methodCallNumber: methodCallNumber)
    }
    
    
    
    
    
}



public protocol JABTouchableViewDelegate {
    
    func touchableViewTouchDidBegin(_ touchableView: JABTouchableView)
    func touchableViewTouchDidChange(_ touchableView: JABTouchableView, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int)
    func touchableViewTouchDidEnd(_ touchableView: JABTouchableView, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int)
    func touchableViewTouchDidCancel(_ touchableView: JABTouchableView, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int)
    
    
}

