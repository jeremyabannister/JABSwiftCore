//
//  AnimatableInterfaceForUIView.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/13/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public protocol AnimatableInterfaceForUIView: InterfaceForUIView { }

public extension AnimatableInterfaceForUIView {
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
      GlobalAnimationState.shouldAnimateChangesLookupTable[element.uniqueIdentifier] = true
      GlobalAnimationState.animationParametersLookupTable[element.uniqueIdentifier] = parameters
      (element as? AnimatableInterfaceForUIView)?.turnOnAnimationMode(withParameters: parameters)
    })
  }
  
  internal func turnOffAnimationMode () {
    interfaceElements.forEach({
      guard let element = $0 else { return }
      GlobalAnimationState.shouldAnimateChangesLookupTable[element.uniqueIdentifier] = false
      (element as? AnimatableInterfaceForUIView)?.turnOffAnimationMode()
    })
  }
}
