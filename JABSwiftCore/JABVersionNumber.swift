//
//  JABVersionNumber.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 8/24/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public class JABVersionNumber: NSObject, Comparable {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    
    // MARK: State
    public var numbers = [Int]()
    
    
    
    
    // **********************************************************************************************************************
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public init (string: String) {
        
        super.init()
        
        if string.isValidVersionNumber() {
            let components = string.componentsSeparatedByString(".")
            for component in components {
                if let number = Int(component) {
                    numbers.append(number)
                }
            }
        } else {
            numbers.append(0)
        }
        
    }
    
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
}

public func == (lhs: JABVersionNumber, rhs: JABVersionNumber) -> Bool {
    
    if lhs.numbers.count == rhs.numbers.count {
        for i in 0 ..< lhs.numbers.count {
            if lhs.numbers[i] != rhs.numbers[i] {
                return false
            }
        }
    } else {
        return false
    }
    
    return true
}


public func > (lhs: JABVersionNumber, rhs: JABVersionNumber) -> Bool {
    
    for i in 0 ..< lhs.numbers.count {
        if rhs.numbers.count > i {
            if lhs.numbers[i] > rhs.numbers[i] {
                return true
            } else if lhs.numbers[i] < rhs.numbers[i] {
                return false
            }
        } else {
            return true
        }
    }
    
    return false
}

public func < (lhs: JABVersionNumber, rhs: JABVersionNumber) -> Bool {
    
    if lhs == rhs {
        return false
    }
    
    if lhs > rhs {
        return false
    }
    
    return true
}
