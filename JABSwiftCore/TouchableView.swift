//
//  TouchableView.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/8/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

// MARK: - Initial Declaration
open class TouchableView: View {
  // Outlet
  public let touchableOutlet: TouchableVisualOutlet?
  
  // Event Callbacks
  private var callbackForWhenTouchBegins: ((TouchEvent)->())?
  private var callbackForWhenTouchChanges: ((TouchEvent)->())?
  private var callbackForWhenTouchEnds: ((TouchEvent)->())?
  private var callbackForWhenTouchCancels: ((TouchEvent)->())?
  
  // Touch Tracking
  private var touchEventHistory: [(touchEvent: TouchEvent, mediaTime: Double)] = []
  
  // Init
  public init (touchableOutlet: TouchableVisualOutlet?) {
    self.touchableOutlet = touchableOutlet
    super.init(outlet: touchableOutlet)
    setupTouchCallback()
  }
  
  public override init () {
    self.touchableOutlet = TouchableVisualOutletFactory.createNewTouchableOutlet()
    super.init(outlet: self.touchableOutlet)
    setupTouchCallback()
  }
}

// MARK: - Setup
private extension TouchableView {
  func setupTouchCallback () {
    touchableOutlet?.whenNewTouchLocationOccurs({ (location, touchState) in
      self.handleNewTouchLocation(location: location, touchState: touchState)
    })
  }
}

// MARK: - Event Listeners
public extension TouchableView {
  func whenTouchBegins (_ callback: @escaping (TouchEvent)->()) {
    callbackForWhenTouchBegins = callback
  }
  func whenTouchChanges (_ callback: @escaping (TouchEvent)->()) {
    callbackForWhenTouchChanges = callback
  }
  func whenTouchEnds (_ callback: @escaping (TouchEvent)->()) {
    callbackForWhenTouchEnds = callback
  }
  func whenTouchCancels (_ callback: @escaping (TouchEvent)->()) {
    callbackForWhenTouchCancels = callback
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
      callbackForWhenTouchBegins?(touchEvent)
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
    
    if touchState == .changed { callbackForWhenTouchChanges?(touchEvent) }
    else if touchState == .ended { callbackForWhenTouchEnds?(touchEvent) }
    else if touchState == .cancelled { callbackForWhenTouchCancels?(touchEvent) }
  }
}
