//
//  TouchEvent.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/9/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public struct TouchEvent {
  public enum State { case began, changed, ended, cancelled }
  public let state: State
  public let locationOnScreen: Point
  public let locationDelta: Point
  public let instantaneousVelocity: Point
  public let averagedVelocity: Point
  public let eventIndex: Int
  
  public static let dummy: TouchEvent = TouchEvent(state: .began, locationOnScreen: .zero, locationDelta: .zero, instantaneousVelocity: .zero, averagedVelocity: .zero, eventIndex: 0)
}
