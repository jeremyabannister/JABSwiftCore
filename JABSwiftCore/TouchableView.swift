//
//  TouchableView.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/8/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

// MARK: - Public API
public extension TouchableView {
  func whenTouchBegins (callback: @escaping (TouchEvent)->()) {
    callbacksForWhenTouchBegins.append(callback)
  }
  func whenTouchChanges (callback: @escaping (TouchEvent)->()) {
    callbacksForWhenTouchChanges.append(callback)
  }
  func whenTouchEnds (callback: @escaping (TouchEvent)->()) {
    callbacksForWhenTouchEnds.append(callback)
  }
  func whenTouchCancels (callback: @escaping (TouchEvent)->()) {
    callbacksForWhenTouchCancels.append(callback)
  }
  
  func cancelTouch () {
    touchableOutlet?.cancelTouch()
  }
}

// MARK: - Initial Declaration
open class TouchableView: View {
  // Outlet
  public let touchableOutlet: TouchableVisualOutlet?
  
  // Event Callbacks
  private var callbacksForWhenTouchBegins: [(TouchEvent)->()] = []
  private var callbacksForWhenTouchChanges: [(TouchEvent)->()] = []
  private var callbacksForWhenTouchEnds: [(TouchEvent)->()] = []
  private var callbacksForWhenTouchCancels: [(TouchEvent)->()] = []
  
  // Touch Tracking
  private var touchEventHistory: [(touchEvent: TouchEvent, mediaTime: Double)] = []
  
  // Init
  public init (touchableOutlet: TouchableVisualOutlet?) {
    self.touchableOutlet = touchableOutlet
    super.init(outlet: self.touchableOutlet)
  }
  
  public override init () {
    self.touchableOutlet = TouchableVisualOutletFactory.createNewTouchableOutlet()
    super.init(outlet: self.touchableOutlet)
  }
  
  override open func commonInit () {
    super.commonInit()
    touchableOutlet?.whenNewTouchLocationOccurs({ (location, touchState) in
      self.handleNewTouchLocation(location: location, touchState: touchState)
    })
  }
}

// MARK: - Touch Handling
private extension TouchableView {
  func handleNewTouchLocation (location: Point, touchState: TouchEvent.State) {
    var touchEvent: TouchEvent
    defer {
      touchEventHistory.append((touchEvent: touchEvent, mediaTime: CurrentMediaTime()))
      if touchState == .ended || touchState == .cancelled { touchEventHistory.removeAll() }
    }
    
    if touchState == .began {
      touchEvent = TouchEvent(state: .began,
                              index: 0,
                              locationOnScreen: location,
                              locationDelta: .zero,
                              instantaneousVelocity: .zero,
                              averagedVelocity: .zero)
      callbacksForWhenTouchBegins.forEach({ $0(touchEvent) })
      return
    }
    
    let currentMediaTime = CurrentMediaTime()
    let locationDelta = location - (touchEventHistory.first?.touchEvent.locationOnScreen ?? .zero)
    guard let previousEvent = touchEventHistory.last else { touchEvent = .dummy; return }
    let instantaneousVelocity = locationDelta/(currentMediaTime - previousEvent.mediaTime)
    let numberToAverage = 5
    let averagedVelocity = touchEventHistory.last(numberToAverage - 1).map({ $0.touchEvent.instantaneousVelocity }).appending(instantaneousVelocity).average
    touchEvent = TouchEvent(state: touchState,
                            index: touchEventHistory.count,
                            locationOnScreen: location,
                            locationDelta: locationDelta,
                            instantaneousVelocity: instantaneousVelocity,
                            averagedVelocity: averagedVelocity)
    
    if touchState == .changed { callbacksForWhenTouchChanges.forEach({ $0(touchEvent) }) }
    else if touchState == .ended { callbacksForWhenTouchEnds.forEach({ $0(touchEvent) }) }
    else if touchState == .cancelled { callbacksForWhenTouchCancels.forEach({ $0(touchEvent) }) }
  }
}
