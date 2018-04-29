//
//  CALayerExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/28/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension CALayer {
  // These shortcuts are for debugging convenience
  public func red () { backgroundColor = UIColor.red.cgColor }
  public func blue () { backgroundColor = UIColor.blue.cgColor }
  public func green () { backgroundColor = UIColor.green.cgColor }
  public func yellow () { backgroundColor = UIColor.yellow.cgColor }
  public func purple () { backgroundColor = UIColor.purple.cgColor }
  public func cyan () { backgroundColor = UIColor.cyan.cgColor }
  public func white () { backgroundColor = UIColor.white.cgColor }
  public func black () { backgroundColor = UIColor.black.cgColor }
  public func lightGray () { backgroundColor = UIColor.lightGray.cgColor }
  public func darkGray () { backgroundColor = UIColor.darkGray.cgColor }
}


public extension CALayer {
  public var x: CGFloat {
    get { return frame.origin.x }
    set { var copy = frame; copy.origin.x = newValue; frame = copy } }
  public var y: CGFloat {
    get { return frame.origin.y }
    set { var copy = frame; copy.origin.y = newValue; frame = copy } }
  public var width: CGFloat {
    get { return frame.size.width }
    set { var copy = frame; copy.size.width = newValue; frame = copy } }
  public var height: CGFloat {
    get { return frame.size.height }
    set { var copy = frame; copy.size.height = newValue; frame = copy } }
  public var origin: CGPoint {
    get { return frame.origin }
    set { var copy = frame; copy.origin = newValue; frame = copy } }
  public var size: CGSize {
    get { return frame.size }
    set { var copy = frame; copy.size = newValue; frame = copy } }
  
  
  public var left: CGFloat { return x }
  public var top: CGFloat { return y }
  public var right: CGFloat { return left + width }
  public var bottom: CGFloat { return top + height }
}
