//
//  UniquelyIdentifiableObject.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/24/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public protocol UniquelyIdentifiableObject: AnyObject {
  var uniqueIdentifier: ObjectIdentifier { get }
}

public extension UniquelyIdentifiableObject {
  public var uniqueIdentifier: ObjectIdentifier {
    return ObjectIdentifier(self)
  }
}
