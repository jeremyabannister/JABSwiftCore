//
//  UIColorExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/19/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    public func dim (_ fraction: CGFloat) -> UIColor {
        
        // Force the fraction to be between 0 and 1
        var modifiedFraction = fraction
        if modifiedFraction > 1 {
            modifiedFraction = 1
        } else if modifiedFraction < 0 {
            modifiedFraction = 0
        }
        
        let redComponent = components.red
        let greenComponent = components.green
        let blueComponent = components.blue
        let alpha = components.alpha
        
        return UIColor(red: redComponent * modifiedFraction, green: greenComponent * modifiedFraction, blue: blueComponent * modifiedFraction, alpha: alpha)
        
    }
    
    public var components:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r,g,b,a)
    }
    
    
}
