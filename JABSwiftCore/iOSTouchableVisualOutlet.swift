//
//  iOSTouchableVisualOutlet.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/8/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

// MARK: - Initial Declaration
class iOSTouchableVisualOutlet: UIView {
  // Stored Properties
  var callbackForWhenNewTouchLocationOccurs: ((Point, TouchEvent.State)->())?
  private lazy var gestureRecognizer: UILongPressGestureRecognizer = {
    UILongPressGestureRecognizer(target: self, action: #selector(touchEventDidOccur(_:)))
  }()
  
  // Init
  init () {
    super.init(frame: .zero)
    setupGestureRecognizer()
  }
  required init? (coder: NSCoder) { return nil }
}

// MARK: - Setup
private extension iOSTouchableVisualOutlet {
  func setupGestureRecognizer () {
    gestureRecognizer.delegate = self
    gestureRecognizer.minimumPressDuration = 0.0001
    gestureRecognizer.allowableMovement = 1000000
    self.addGestureRecognizer(gestureRecognizer)
  }
}

// MARK: - Touch Events
@objc extension iOSTouchableVisualOutlet {
  final func touchEventDidOccur (_ gestureRecognizer: UILongPressGestureRecognizer) {
    let stateLookupDict: [UIGestureRecognizerState: TouchEvent.State] = [.began: .began, .changed: .changed, .ended: .ended, .cancelled: .cancelled]
    guard let touchState = stateLookupDict[gestureRecognizer.state] else { return }
    guard let screenView = staticOnScreenView else { print("ERROR: You must set staticOnScreenView."); return }
    let locationOnScreen = gestureRecognizer.location(in: screenView).asPoint
    callbackForWhenNewTouchLocationOccurs?(locationOnScreen, touchState)
  }
}

// MARK: - UIGestureRecognizerDelegate
extension iOSTouchableVisualOutlet: UIGestureRecognizerDelegate {
  final func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  final func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    return true
  }
  
  open func cancelTouch () {
    gestureRecognizer.isEnabled = false
    gestureRecognizer.isEnabled = true
  }
}
