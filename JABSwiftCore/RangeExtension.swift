//
//  RangeExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 12/12/17.
//  Copyright © 2017 Jeremy Bannister. All rights reserved.
//

import Foundation

extension Range {
    func isFullyEncompassed (by ranges: [Range]) -> Bool {
        var widdledRange = self
        let sortedRanges = ranges.sorted { (lhs, rhs) -> Bool in return lhs.lowerBound < rhs.lowerBound }
        for range in sortedRanges {
            if range.lowerBound > widdledRange.lowerBound { return false }
            if range.upperBound <= widdledRange.lowerBound { continue }
            if range.upperBound >= widdledRange.upperBound { return true }
            widdledRange = range.upperBound ..< widdledRange.upperBound
        }
        return false
    }
}
