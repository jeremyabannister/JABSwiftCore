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
  func currentlyPresentedValue (forProperty propertyString: String) -> Any?
}

public extension AnimatableEntity {
  public func animate (to newValue: Any?, forProperty propertyString: String) {
    if shouldAnimateChangesLookupTable[self.objectIdentifier] != true { return }
    guard let animationParameters = animationParametersLookupTable[self.objectIdentifier] else { return }
    let animation = CABasicAnimation(keyPath: propertyString, fromValue: currentlyPresentedValue(forProperty: propertyString), toValue: newValue)
    animation.duration = animationParameters.duration
    animation.timingFunction = animationParameters.timingFunction.mediaTimingFunction
    layer.removeAnimation(forKey: propertyString)
    layer.add(animation, forKey: propertyString)
  }
}

extension UIView: AnimatableEntity {
  public func currentlyPresentedValue (forProperty propertyString: String) -> Any? {
    let shouldDeriveFromPresentationLayer = layer.animation(forKey: propertyString) != nil
    switch propertyString {
    case "bounds": return shouldDeriveFromPresentationLayer ? layer.presentation()?.bounds ?? layer.bounds : layer.bounds
    case "position": return shouldDeriveFromPresentationLayer ? layer.presentation()?.position ?? layer.position : layer.position
    case "backgroundColor": return shouldDeriveFromPresentationLayer ? layer.presentation()?.backgroundColor ?? layer.backgroundColor : layer.backgroundColor
    case "opacity": return shouldDeriveFromPresentationLayer ? layer.presentation()?.opacity ?? layer.opacity : layer.opacity
    case "cornerRadius": return shouldDeriveFromPresentationLayer ? layer.presentation()?.cornerRadius ?? layer.cornerRadius : layer.cornerRadius
    case "shadowOpacity": return shouldDeriveFromPresentationLayer ? layer.presentation()?.shadowOpacity ?? layer.shadowOpacity : layer.shadowOpacity
    case "shadowRadius": return shouldDeriveFromPresentationLayer ? layer.presentation()?.shadowRadius ?? layer.shadowRadius : layer.shadowRadius
    case "shadowOffset": return shouldDeriveFromPresentationLayer ? layer.presentation()?.shadowOffset ?? layer.shadowOffset : layer.shadowOffset
    case "shadowColor": return shouldDeriveFromPresentationLayer ? layer.presentation()?.shadowColor ?? layer.shadowColor : layer.shadowColor
    default: return nil
    }
  }
}
