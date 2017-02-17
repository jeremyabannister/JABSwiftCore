//
//  SequenceExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 2/16/17.
//  Copyright © 2017 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
