//
//  MutableCollectionExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 2/16/17.
//  Copyright © 2017 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension MutableCollection {
  /// Shuffles the contents of this collection.
  mutating func shuffle() {
    let c = count
    guard c > 1 else { return }
    
    for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
      let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
      guard d != 0 else { continue }
      let i = index(firstUnshuffled, offsetBy: d)
      self.swapAt(firstUnshuffled, i)
    }
  }
}
