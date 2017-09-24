//
//  JABVersionNumber.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 8/24/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

open class JABVersionNumber: NSObject, Comparable, NSCoding {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    
    // MARK: State
    open var numbers = [Int]()
    open var string: String {
        get {
            if numbers.count == 0 { return "" }
            var string = "\(numbers.first!)"
            for i in 1 ..< numbers.count { string += ".\(numbers[i])" }
            return string
        }
    }
    
    
    // **********************************************************************************************************************
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public init? (string: String?) {
        
        super.init()
        guard let string = string else { return nil }
        if !string.isValidVersionNumber() { return nil }
        
        let components = string.components(separatedBy: ".")
        for component in components { if let number = Int(component) { numbers.append(number) } }
        
    }
    
    
    // MARK:
    // MARK: NSCoding
    // MARK:
    
    required public init(coder aDecoder: NSCoder) {
        if let numbers = aDecoder.decodeObject(forKey: "numbers") as? [Int] { self.numbers = numbers }
        else { self.numbers = [Int]() }
    }
    
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(numbers, forKey: "numbers")
    }
    
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
}

public func == (lhs: JABVersionNumber, rhs: JABVersionNumber) -> Bool {
    if lhs.numbers.count == rhs.numbers.count { for i in 0 ..< lhs.numbers.count { if lhs.numbers[i] != rhs.numbers[i] { return false } } }
    else { return false }
    return true
}


public func > (lhs: JABVersionNumber, rhs: JABVersionNumber) -> Bool {
    for i in 0 ..< lhs.numbers.count {
        if rhs.numbers.count > i {
            if lhs.numbers[i] > rhs.numbers[i] { return true }
            else if lhs.numbers[i] < rhs.numbers[i] { return false }
        } else { return true }
    }
    return false
}

public func < (lhs: JABVersionNumber, rhs: JABVersionNumber) -> Bool {
    if lhs == rhs { return false }
    if lhs > rhs { return false }
    return true
}

