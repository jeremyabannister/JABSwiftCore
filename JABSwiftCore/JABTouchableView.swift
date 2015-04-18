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
        println("initing touchable view da")
        createTouchRecognitionSystem()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init()
    }
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    public func createTouchRecognitionSystem () {
        
        touchManager = JABTouchManager(newTouchDomain: self)
        touchManager?.delegate = self
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
    public func touchDidBegin(location: CGPoint) {
        delegate?.touchableViewTouchDidBegin(self, location: location)
    }
    
    public func touchDidChange(location: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        delegate?.touchableViewTouchDidChange(self, location: location, xDistance: xDistance, yDistance: yDistance, methodCallNumber: methodCallNumber)
    }
    
    public func touchDidEnd(location: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        delegate?.touchableViewTouchDidEnd(self, location: location, xDistance: xDistance, yDistance: yDistance, methodCallNumber: methodCallNumber)
    }
    
    public func touchDidCancel(location: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        delegate?.touchableViewTouchDidCancel(self, location: location, xDistance: xDistance, yDistance: yDistance, methodCallNumber: methodCallNumber)
    }
    
    
    
    
    
    
}



public protocol JABTouchableViewDelegate {
    
    func touchableViewTouchDidBegin(touchableView: JABTouchableView, location: CGPoint)
    func touchableViewTouchDidChange(touchableView: JABTouchableView, location: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int)
    func touchableViewTouchDidEnd(touchableView: JABTouchableView, location: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int)
    func touchableViewTouchDidCancel(touchableView: JABTouchableView, location: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int)
    
    
}