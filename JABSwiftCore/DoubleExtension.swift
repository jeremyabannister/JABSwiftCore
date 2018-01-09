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
        // The zero condition is here due to an unexplored issue causing the method to return "$-0.00" before this condition was added
        if self == 0 { return "$0.00" }
        else if self < 0 { return "-$".appendingFormat("%.2f", -self) }
        else { return "$".appendingFormat("%.2f", self) }
    }
    
    public func flooredToDecimalPlaces (_ numberOfDecimalPlaces: Int) -> Double {
        return floor(self * pow(10, Double(numberOfDecimalPlaces)))/pow(10, Double(numberOfDecimalPlaces))
    }
    
    public func bounded (by lowerBound: Double?, _ upperBound: Double?) -> Double {
        return (self < lowerBound ?? self) ? (lowerBound ?? self) : ((self > upperBound ?? self) ? (upperBound ?? self) : self)
    }
}

