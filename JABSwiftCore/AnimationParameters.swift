//
//  AnimationParameters.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/6/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

internal struct AnimationParameters {
  var duration: TimeInterval
  var timingFunction: TimingFunction
  var completion: ((Bool) -> ())?
}
