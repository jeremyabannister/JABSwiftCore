//
//  TimingFunction.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/25/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public enum TimingFunction {
  case easeInOut, easeIn, easeOut, linear, custom(Float, Float, Float, Float)
  public var mediaTimingFunction: CAMediaTimingFunction {
    switch self {
      case .easeInOut: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      case .easeIn: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
      case .easeOut: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
      case .linear: return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
      case .custom(let one, let two, let three, let four): return CAMediaTimingFunction(controlPoints: one, two, three, four)
    }
  }
}
