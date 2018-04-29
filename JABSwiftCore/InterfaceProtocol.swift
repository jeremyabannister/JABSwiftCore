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




extension UIView: InterfaceElement { }
extension CALayer: InterfaceElement { }


public struct AnimationParameters {
  public var duration: TimeInterval
  public var timingFunction: TimingFunction
  public var completion: ((Bool) -> ())?
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
  var interfaceElements: [InterfaceElement?] { get }
  func addUI ()
  func updateUI ()
}

public extension Interface where Self: UIView {
  func addUI () {
    for interfaceElement in interfaceElements {
      if let subview = interfaceElement as? UIView { addSubview(subview) }
      else if let sublayer = interfaceElement as? CALayer { layer.addSublayer(sublayer) }
    }
  }
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
      guard let element = $0 else { return }
      shouldAnimateChangesLookupTable[element.uniqueIdentifier] = true
      animationParametersLookupTable[element.uniqueIdentifier] = parameters
      (element as? AnimatableInterface)?.turnOnAnimationMode(withParameters: parameters)
    })
  }
  
  public func turnOffAnimationMode () {
    interfaceElements.forEach({
      guard let element = $0 else { return }
      shouldAnimateChangesLookupTable[element.uniqueIdentifier] = false
      (element as? AnimatableInterface)?.turnOffAnimationMode()
    })
  }
}

public extension Array where Element: InterfaceElement {
  public var asInterfaceElements: [InterfaceElement] { return self as [InterfaceElement] }
}

public func test () {
  //  func animate (_ updateCode: () -> (), duration: TimeInterval = defaultAnimationDuration, timingFunction: TimingFunction = .easeInOut, completion: @escaping (Bool) -> () = { (completed) in }) {
  //    let oldDuration = JABView.animateDuration
  //    let oldTimingFunction = JABView.animationTimingFunction
  //
  //    JABView.isGeneratingAnimatedUpdate = true
  //    JABView.animateDuration = duration
  //    JABView.animationTimingFunction = timingFunction
  //
  //    updateCode()
  //    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) { completion(true) }
  //
  //    JABView.isGeneratingAnimatedUpdate = false
  //    JABView.animateDuration = oldDuration
  //    JABView.animationTimingFunction = oldTimingFunction
  //  }
  //
  //
  //  func animatedUpdate (duration: TimeInterval = defaultAnimationDuration, timingFunction: TimingFunction = .easeInOut, completion: @escaping (Bool) -> () = { (completed) in }) {
  //    animate({ self.updateAllUI() }, duration: duration, timingFunction: timingFunction, completion: completion)
  //  }
}
