//
//  GlobalAnimationState.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/6/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

internal struct GlobalAnimationState {
  static var shouldAnimateChangesLookupTable: [ObjectIdentifier: Bool] = [:]
  static var animationParametersLookupTable: [ObjectIdentifier: AnimationParameters] = [:]
}
