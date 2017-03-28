//
//  UIImageExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/21/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit


public extension UIImage {
    
    
    
    // MARK: Coloring
    public func imageTintedWithColor(_ color: UIColor?) -> UIImage {
        // This method is designed for use with template images, i.e. solid-coloured mask-like images.
        return imageTintedWithColor(color, fraction: 0.0) // default to a fully tinted mask of the image.
    }
    
    public func imageTintedWithColor(_ color: UIColor?, fraction: CGFloat) -> UIImage {
        
        if color == nil { return self }
        // Construct new image the same size as this one.
        var image = UIImage()
        if UIScreen.instancesRespond(to: #selector(NSDecimalNumberBehaviors.scale)) {
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        } else {
            UIGraphicsBeginImageContext(size)
        }
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        // Composite tint color at its own opacity.
        color!.set()
        UIRectFill(rect)
        
        // Mask tint color-swatch to this image's opaque mask.
        // We want behaviour like NSCompositeDestinationIn on Mac OS X.
        draw(in: rect, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        
        // Finally, composite this image over the tinted mask at desired opacity.
        if fraction > 0.0 {
            draw(in: rect, blendMode: CGBlendMode.sourceAtop, alpha: fraction)
        }
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
        
    }
    
    
    
    // MARK: Resizing
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
