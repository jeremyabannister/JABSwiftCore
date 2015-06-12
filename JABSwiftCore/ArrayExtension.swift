//
//  ArrayExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/28/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation


extension Array {
    func indexOf<T : Equatable>(x:T) -> Int? {
        for i in 0..<self.count {
            if self[i] as! T == x {
                return i
            }
        }
        return nil
    }
}
