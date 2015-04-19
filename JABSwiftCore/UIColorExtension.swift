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
    
    
    public func dim (percentage: CGFloat) -> UIColor {
        
        // Force the percentage to be between 0 and 100
        var modifiedPercentage = percentage
        if ( modifiedPercentage > 100 ) {
            modifiedPercentage = 100
        } else if ( modifiedPercentage < 0 ) {
            modifiedPercentage = 0
        }
        
        let redComponent = components.red
        let greenComponent = components.green
        let blueComponent = components.blue
        let alpha = components.alpha
        
        return UIColor(red: redComponent * (modifiedPercentage/100.0), green: greenComponent * (modifiedPercentage/100.0), blue: blueComponent * (modifiedPercentage/100.0), alpha: alpha)
        
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
