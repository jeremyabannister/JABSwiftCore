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
    public var parentView: UIView? {
        didSet {
            touchManager?.parentView = parentView
        }
    }
    
    
    
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
        touchManager?.parentView = parentView
        userInteractionEnabled = true
        
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
    public func touchDidBegin(locationInParentView:CGPoint?, locationInView:CGPoint) {
        delegate?.touchableViewTouchDidBegin(self, locationInParentView: locationInParentView, locationInView: locationInView)
    }
    
    public func touchDidChange(locationInParentView:CGPoint?, locationInView:CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        delegate?.touchableViewTouchDidChange(self, locationInParentView: locationInParentView, locationInView: locationInView, xDistance: xDistance, yDistance: yDistance, methodCallNumber: methodCallNumber)
    }
    
    public func touchDidEnd(locationInParentView:CGPoint?, locationInView:CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        delegate?.touchableViewTouchDidEnd(self, locationInParentView: locationInParentView, locationInView: locationInView, xDistance: xDistance, yDistance: yDistance, methodCallNumber: methodCallNumber)
    }
    
    public func touchDidCancel(locationInParentView:CGPoint?, locationInView:CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        delegate?.touchableViewTouchDidCancel(self, locationInParentView: locationInParentView, locationInView: locationInView, xDistance: xDistance, yDistance: yDistance, methodCallNumber: methodCallNumber)
    }
    
    
    
    
    
    
}



public protocol JABTouchableViewDelegate {
    
    func touchableViewTouchDidBegin(touchableView: JABTouchableView, locationInParentView:CGPoint?, locationInView:CGPoint)
    func touchableViewTouchDidChange(touchableView: JABTouchableView, locationInParentView:CGPoint?, locationInView:CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int)
    func touchableViewTouchDidEnd(touchableView: JABTouchableView, locationInParentView:CGPoint?, locationInView:CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int)
    func touchableViewTouchDidCancel(touchableView: JABTouchableView, locationInParentView:CGPoint?, locationInView:CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int)
    
    
}