//
//  SinglePropertyAnimation.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/26/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public struct SinglePropertyAnimation <PropertyType> {
  var keyPath: String
  var fromValue: PropertyType?
  var toValue: PropertyType?
  var animationParameters: AnimationParameters
}
