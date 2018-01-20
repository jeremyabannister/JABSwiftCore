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
  
  // MARK: Delegate
  weak open var locationTesterDelegate: JABLocationTesterDelegate?
  
  // MARK: State
  // Public
  open var color: UIColor = .black
  
  // Private
  fileprivate var location = CGPoint()
  fileprivate var mediaTimeOfLastTap = CACurrentMediaTime()
  
  // MARK: UI
  fileprivate let horizontalLine = UIView()
  fileprivate let verticalLine = UIView()
  
  // MARK: Parameters
  
  
  // **********************************************************************************************************************
  
  
  // MARK:
  // MARK: Methods
  // MARK:
  
  // MARK:
  // MARK: Init
  // MARK:
  
  override public init () {
    super.init()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    print("Should not be initializing from coder \(self)")
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
    
    horizontalLine.backdropColor = color
    
  }
  
  fileprivate func positionHorizontalLine () {
    
    var newSite = CGRect.zero
    
    newSite.size.width = width
    newSite.size.height = 0.5
    
    newSite.origin.x = (width - newSite.size.width)/2
    newSite.origin.y = location.y - (newSite.size.height/2)
    
    horizontalLine.site = newSite
    
  }
  
  
  // MARK: Vertical Line
  fileprivate func configureVerticalLine () {
    
    verticalLine.backdropColor = color
    
  }
  
  fileprivate func positionVerticalLine () {
    
    var newSite = CGRect.zero
    
    newSite.size.width = 0.5
    newSite.size.height = height
    
    newSite.origin.x = location.x - (newSite.size.width/2)
    newSite.origin.y = (height - newSite.size.height)/2
    
    verticalLine.site = newSite
    
  }
  
  
  // MARK:
  // MARK: Actions
  // MARK:
  
  
  // MARK:
  // MARK: Delegate Methods
  // MARK:
  
  // MARK: Touch Manager
  override open func touchDidBegin(_ touchManager: JABTouchManager) {
    
    guard let touchRecognizer = touchManager.touchRecognizer else { return }
    location = touchRecognizer.location(in: self)
    print("(\(location.x), \(location.y))")
    animatedUpdate()
    
  }
  
  override open func touchDidChange(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
    
    guard let touchRecognizer = touchManager.touchRecognizer else { return }
    location = touchRecognizer.location(in: self)
    print("(\(location.x), \(location.y))")
    updateAllUI()
    
  }
  
  override open func touchDidEnd(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
    
    guard let touchRecognizer = touchManager.touchRecognizer else { return }
    location = touchRecognizer.location(in: self)
    print("(\(location.x), \(location.y))")
    updateAllUI()
    
    
    if CACurrentMediaTime() - mediaTimeOfLastTap < 0.2 {
      locationTesterDelegate?.locationTesterDelegateDidCancel()
    } else {
      mediaTimeOfLastTap = CACurrentMediaTime()
    }
    
  }
  
  override open func touchDidCancel(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
    
    guard let touchRecognizer = touchManager.touchRecognizer else { return }
    location = touchRecognizer.location(in: self)
    print("(\(location.x), \(location.y))")
    updateAllUI()
    
  }
  
}


public protocol JABLocationTesterDelegate: class {
  func locationTesterDelegateDidCancel ()
}

