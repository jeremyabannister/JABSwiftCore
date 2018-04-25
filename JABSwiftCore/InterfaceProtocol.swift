//
//  InterfaceProtocol.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/7/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

public protocol InterfaceProtocol: class {
  var superview: UIView? { get set }
  func setSuperview (_ superview: UIView?)
  
  var interfaceElements: [InterfaceElementOld] { get }
  func addInterfaceElements ()
  func updateInterfaceElements ()
}
public extension InterfaceProtocol {
  var width: CGFloat { return superview?.width ?? 0 }
  var height: CGFloat { return superview?.height ?? 0 }
  
  func addInterfaceElements () { interfaceElements.forEach({ addInterfaceElement($0) }) }
  func updateInheritedInterface () { }
  func setSuperview (_ superview: UIView?) { self.superview = superview }
  func addInterfaceElement (_ interfaceElement: InterfaceElementOld) { interfaceElement.addableViews.forEach({ superview?.addSubview($0) }) }
}







public struct AnimationParameters {
  var duration: TimeInterval
  var timingFunction: TimingFunction
  var completion: ((Bool) -> ())?
}
public var shouldAnimateChangesLookupTable: [ObjectIdentifier: Bool] = [:]
public var animationParametersLookupTable: [ObjectIdentifier: AnimationParameters] = [:]


public protocol InterfaceElement {
  var uniqueIdentifier: ObjectIdentifier { get }
}

public extension InterfaceElement where Self: NSObject {
  var uniqueIdentifier: ObjectIdentifier { return self.objectIdentifier }
}

public protocol Interface: InterfaceElement {
  var interfaceElements: [InterfaceElement] { get }
  func updateUI ()
}

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
  
  public func turnOnAnimationMode (withParameters parameters: AnimationParameters) {
    interfaceElements.forEach({
      shouldAnimateChangesLookupTable[$0.uniqueIdentifier] = true
      animationParametersLookupTable[$0.uniqueIdentifier] = parameters
      ($0 as? AnimatableInterface)?.turnOnAnimationMode(withParameters: parameters)
    })
  }
  
  public func turnOffAnimationMode () {
    interfaceElements.forEach({
      shouldAnimateChangesLookupTable[$0.uniqueIdentifier] = false
      ($0 as? AnimatableInterface)?.turnOffAnimationMode()
    })
  }
}
