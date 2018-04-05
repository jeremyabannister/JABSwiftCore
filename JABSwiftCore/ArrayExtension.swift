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
  
  
  // ---------------
  // MARK: Print
  // ---------------
  public func print () { Swift.print(self) }
}


// Numeric Arrays
extension Array where Element == Double {
  public var sum: Double { var total: Double = 0; for number in self { total += number }; return total }
  public var average: Double { if count == 0 { return 0 }; return sum/Double(count) }
  public var variance: Double { let average = self.average; return self.map({ pow($0 - average, 2) }).average }
  public var standardDeviation: Double { return sqrt(self.variance) }
}

extension Array where Element == Int {
  public var asDoubles: [Double] { return self.map({ Double($0) }) }
  public var sum: Int { return Int(self.asDoubles.sum) }
  public var average: Double { return self.asDoubles.average }
  public var variance: Double { return self.asDoubles.variance }
  public var standardDeviation: Double { return self.asDoubles.standardDeviation }
}
extension Array where Element == Float {
  public var asDoubles: [Double] { return self.map({ Double($0) }) }
  public var sum: Float { return Float(self.asDoubles.sum) }
  public var average: Float { return Float(self.asDoubles.average) }
  public var variance: Float { return Float(self.asDoubles.variance) }
  public var standardDeviation: Float { return Float(self.asDoubles.standardDeviation) }
}
extension Array where Element == CGFloat {
  public var asDoubles: [Double] { return self.map({ Double($0) }) }
  public var sum: CGFloat { return CGFloat(self.asDoubles.sum) }
  public var average: CGFloat { return CGFloat(self.asDoubles.average) }
  public var variance: CGFloat { return CGFloat(self.asDoubles.variance) }
  public var standardDeviation: CGFloat { return CGFloat(self.asDoubles.standardDeviation) }
}
