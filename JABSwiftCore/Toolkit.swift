//
//  Toolkit.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 3/26/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit


open class Toolkit {
    
    // MARK:
    // MARK: Strings
    // MARK:
    
    
    // MARK:
    // MARK: Arrays
    // MARK:
    
    open static func removeObject<T : Equatable>(_ object: T, fromArray array: inout [T]) {
        for i in 0 ..< array.count { if array[i] == object { array.remove(at: i); return } }
    }
    
}



