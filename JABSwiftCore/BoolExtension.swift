//
//  BoolExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 10/14/17.
//  Copyright © 2017 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension Bool {
    public func xOr (_ otherBool: Bool) -> Bool { return (self || otherBool) && !(self && otherBool) }
}
