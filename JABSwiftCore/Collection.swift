//
//  Collection.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 3/31/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension Collection where Element: Equatable {
  func removingDuplicates () -> [Element] {
    var uniques: [Element] = []
    for element in self { if !uniques.contains(element) { uniques.append(element) } }
    return uniques
  }
}
