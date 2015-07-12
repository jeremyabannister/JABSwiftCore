//
//  DoubleExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 7/12/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension Double {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK: Conversion
    public func dollarAmountString () -> String {
        if self < 0 {
            return "-$".stringByAppendingFormat("%.2f", -self)
        } else {
            return "$".stringByAppendingFormat("%.2f", self)
        }
    }
    
}