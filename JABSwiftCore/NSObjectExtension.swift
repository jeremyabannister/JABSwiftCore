//
//  NSObjectExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/25/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public extension NSObject {
  func storeObject (_ object: AnyObject, forKey key: inout String) {
    objc_setAssociatedObject(self, &key, object, .OBJC_ASSOCIATION_RETAIN)
  }
  func retrieveObject (forKey key: inout String) -> Any? {
    return objc_getAssociatedObject(self, &key)
  }
}

public extension NSObject {
  var objectIdentifier: ObjectIdentifier { return ObjectIdentifier(self) }
}
