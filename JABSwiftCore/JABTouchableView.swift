//
//  JABTouchableView.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/11/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

open class JABTouchableView: UIView, JABTouchManagerDelegate {
  
  // ----------------------------------------------------------------------
  // MARK: Properties
  // ----------------------------------------------------------------------
  
  // ---------------
  // MARK: Delegate
  // ---------------
  weak open var delegate: JABTouchableViewDelegate?
  
  // ------------
  // MARK: State
  // ------------
  open var touchManager: JABTouchManager?
  
  // ------------------
  // MARK: UI Elements
  // ------------------
  
  // --------------------
  // MARK: UI Parameters
  // --------------------
  
  
  
  
  
  // ----------------------------------------------------------------------
  // MARK: Methods
  // ----------------------------------------------------------------------
  
  
  // -----------
  // MARK: Init
  // -----------
  public init () {
    super.init(frame: .zero)
    touchManager = JABTouchManager(touchDomain: self)
    touchManager?.delegate = self
  }
  
  required public init?(coder aDecoder: NSCoder) { fatalError() }
  
  
  // ----------------------
  // MARK: Adding Subviews
  // ----------------------
  
  
  // ----------------------------------
  // MARK: UI Element -
  // ----------------------------------
  
  
  // ----------------------------------------------------------------------
  // MARK: Actions
  // ----------------------------------------------------------------------
  
  
  // ----------------------------------------------------------------------
  // MARK: Delegate Methods
  // ----------------------------------------------------------------------
  
  // ------------------------------
  // MARK: JABTouchManagerDelegate
  // ------------------------------
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


public protocol JABTouchableViewDelegate: class {
  func touchableViewTouchDidBegin(_ touchableView: JABTouchableView)
  func touchableViewTouchDidChange(_ touchableView: JABTouchableView, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int)
  func touchableViewTouchDidEnd(_ touchableView: JABTouchableView, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int)
  func touchableViewTouchDidCancel(_ touchableView: JABTouchableView, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int)
}

