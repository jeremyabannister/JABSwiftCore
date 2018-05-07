//
//  AnimatableInterface.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/6/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public protocol AnimatableInterface: Interface { }

public extension AnimatableInterface {
  public func animate (_ updateCode: () -> (), duration: TimeInterval = defaultAnimationDuration, timingFunction: TimingFunction = .easeInOut, completion: ((Bool) -> ())? = nil) {
    let animationParameters = AnimationParameters(duration: duration, timingFunction: timingFunction, completion: completion)
    
    turnOnAnimationMode(withParameters: animationParameters)
    updateCode()
    turnOffAnimationMode()
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) { completion?(true) }
  }
  
  public func animatedUpdate (duration: TimeInterval = defaultAnimationDuration, timingFunction: TimingFunction = .easeInOut, completion: @escaping (Bool) -> () = { (didComplete) in }) {
    animate({ self.updateUI() }, duration: duration, timingFunction: timingFunction, completion: completion)
  }
  
  internal func turnOnAnimationMode (withParameters parameters: AnimationParameters) {
    interfaceElements.forEach({
      guard let element = $0 else { return }
      GlobalAnimationState.shouldAnimateChangesLookupTable[element.objectIdentifier] = true
      GlobalAnimationState.animationParametersLookupTable[element.objectIdentifier] = parameters
      (element as? AnimatableInterface)?.turnOnAnimationMode(withParameters: parameters)
    })
  }
  
  internal func turnOffAnimationMode () {
    interfaceElements.forEach({
      guard let element = $0 else { return }
      GlobalAnimationState.shouldAnimateChangesLookupTable[element.objectIdentifier] = false
      (element as? AnimatableInterface)?.turnOffAnimationMode()
    })
  }
}
