//
//  ArrayExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/28/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation


extension Array {
  
  // -----------
  // MARK: JSON
  // -----------
  public var jsonString: String? {
    do {
      let contactsAsJSONData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
      return String(data: contactsAsJSONData, encoding: String.Encoding.utf8)
    } catch {  }
    return nil
  }
  
  public mutating func safeInsert (_ element: Element, atIndex index: Int) {
    if index < 0 { frontAppend(element); return }
    if self.count <= index { self.append(element) }
    else { self.insert(element, at: index) }
  }
  
  public mutating func frontAppend (_ element: Element) {
    safeInsert(element, atIndex: 0)
  }
  
  public mutating func safeRemove (at index: Int?) {
    guard let index = index, self.count > index else { return }
    self.remove(at: index)
  }
}


// Numeric Arrays
extension Array where Element == Int {
  public var average: Double { if count == 0 { return 0 }; return Double(sum)/Double(count) }
  public var sum: Int { var total: Int = 0; for number in self { total += number }; return total }
}
extension Array where Element == Float {
  public var average: Float { if count == 0 { return 0 }; return sum/Float(count) }
  public var sum: Float { var total: Float = 0; for number in self { total += number }; return total }
}
extension Array where Element == Double {
  public var average: Double { if count == 0 { return 0 }; return sum/Double(count) }
  public var sum: Double { var total: Double = 0; for number in self { total += number }; return total }
}
extension Array where Element == CGFloat {
  public var average: CGFloat { if count == 0 { return 0 }; return sum/CGFloat(count) }
  public var sum: CGFloat { var total: CGFloat = 0; for number in self { total += number }; return total }
}

