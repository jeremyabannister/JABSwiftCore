//
//  AnimatableEntity.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/26/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation

public protocol AnimatableEntity where Self: NSObject {
  var layer: CALayer { get }
}

public extension AnimatableEntity {
  public func animate (to newValue: Any?, forProperty propertyString: String) {
    if shouldAnimateChangesLookupTable[self.objectIdentifier] != true { return }
    guard let animationParameters = animationParametersLookupTable[self.objectIdentifier] else { return }
    let animation = CABasicAnimation(keyPath: propertyString, fromValue: currentlyPresentedValue(forProperty: propertyString), toValue: newValue)
    animation.duration = animationParameters.duration
    animation.timingFunction = animationParameters.timingFunction.mediaTimingFunction
    animation.fillMode = kCAFillModeForwards
    layer.removeAnimation(forKey: propertyString)
    layer.add(animation, forKey: propertyString)
  }
  
  public func currentlyPresentedValue (forProperty propertyString: String) -> Any? {
    let layerToQuery = layer.animation(forKey: propertyString) == nil ? layer : layer.presentation() ?? layer
    return layerToQuery.value(forKey: propertyString)
  }
}

extension UIView: AnimatableEntity { }
extension CALayer: AnimatableEntity {
  public var layer: CALayer { return self }
}
