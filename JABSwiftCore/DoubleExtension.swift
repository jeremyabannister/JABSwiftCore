//
//  DoubleExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 7/12/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension Double {
  public func dollarAmountString () -> String {
    // The zero condition is here due to an unexplored issue causing the method to return "$-0.00" before this condition was added
    if self == 0 { return "$0.00" }
    else if self < 0 { return "-$".appendingFormat("%.2f", -self) }
    else { return "$".appendingFormat("%.2f", self) }
  }
}

