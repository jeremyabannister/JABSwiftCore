//
//  BoolExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 10/14/17.
//  Copyright © 2017 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension Bool {
    public init? (_ string: String) { if ["true", "false"].contains(string.lowercased()) { self = (string.lowercased() == "true") } else { return nil } }
    public func xOr (_ otherBool: Bool) -> Bool { return (self || otherBool) && !(self && otherBool) }
}
