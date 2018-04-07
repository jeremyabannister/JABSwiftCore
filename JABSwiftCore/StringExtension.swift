//
//  StringExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 7/12/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension String {
    
  // ----------------------
  // MARK: Subscript
  // ----------------------
  subscript (index: Int) -> Substring? {
    if !self.hasIndex(index) { return nil }
    let stringIndex = self.index(self.startIndex, offsetBy: index)
    return self[stringIndex ... stringIndex]
  }
  subscript (range: CountableRange<Int>) -> Substring {
    let lowerBound = self.ensurePosition(range.lowerBound)
    let upperBound = self.ensurePosition(range.upperBound)
    return self[self.index(self.startIndex, offsetBy: lowerBound) ..< self.index(self.startIndex, offsetBy: upperBound)]
  }
  subscript (closedRange: CountableClosedRange<Int>) -> Substring {
    var lowerBound = self.ensurePosition(closedRange.lowerBound)
    var upperBound = self.ensurePosition(closedRange.upperBound)
    if lowerBound == upperBound && lowerBound == count { return "" }
    lowerBound = self.ensureIndex(lowerBound)
    upperBound = self.ensureIndex(upperBound)
    return self[self.index(self.startIndex, offsetBy: lowerBound) ... self.index(self.startIndex, offsetBy: upperBound)]
  }
  subscript (partialRangeFrom: CountablePartialRangeFrom<Int>) -> Substring {
    if partialRangeFrom.lowerBound >= count { return "" }
    let lowerBound = self.ensureIndex(partialRangeFrom.lowerBound)
    return self[self.index(self.startIndex, offsetBy: lowerBound)...]
  }
  subscript (partialRangeUpTo: PartialRangeUpTo<Int>) -> Substring {
    let upperBound = self.ensurePosition(partialRangeUpTo.upperBound)
    return self[..<self.index(self.startIndex, offsetBy: upperBound)]
  }
  subscript (partialRangeThrough: PartialRangeThrough<Int>) -> Substring {
    if partialRangeThrough.upperBound < 0 { return "" }
    let upperBound = self.ensureIndex(partialRangeThrough.upperBound)
    return self[...self.index(self.startIndex, offsetBy: upperBound)]
  }
  
  // An index marks the locations of the characters, while a position marks the locations between characters
  public func hasIndex (_ index: Int) -> Bool { return index == self.ensureIndex(index) }
  public func ensureIndex (_ index: Int) -> Int { return index < 0 ? 0 : (index >= count ? count - 1 : index) }
  public func hasPosition (_ position: Int) -> Bool { return position == self.ensurePosition(position) }
  public func ensurePosition (_ position: Int) -> Int { return position < 0 ? 0 : (position > count ? count : position) }
  
  // ----------------------
  // MARK: Format Checking
  // ----------------------
  public func isPurelyCharacterSet (_ characterSet: [Character]) -> Bool {
    if count == 0 { return true }
    for i in 0 ..< count { if !characterSet.contains(self[self.index(self.startIndex, offsetBy: i)]) { return false } }
    return true
  }
  
  public var isWholeNumber: Bool { return self.isPurelyCharacterSet(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]) }
  public var isInteger: Bool {
    if count == 0 { return false }
    if self[0] == "-" { return String(self.decapitated()).isWholeNumber }
    else { return isWholeNumber }
  }
  public var isFloatingPointNumber: Bool {
    let split = components(separatedBy: ".")
    if split.count == 0 { return isInteger }
    else if split.count == 1 { return split[0].isInteger }
    else if split.count == 2 { return split[0].isInteger && split[1].isWholeNumber }
    return false
  }
  public func isCurrencyAmount (currencySymbol: String) -> Bool {
    return components(separatedBy: currencySymbol).joined().isFloatingPointNumber
  }
  public var isDollarAmount: Bool { return isCurrencyAmount(currencySymbol: "$") }
  public var isVersionNumber: Bool {
    for component in components(separatedBy: ".") { if !component.isWholeNumber { return false } }
    return true
  }
  public var isValidEmailAddress: Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
  }
  public var isHexCode: Bool {
    if !(count == 4 || count == 7) { return false }
    if self[0] != "#" { return false }
    let code = self[1...].lowercased()
    return String(code).isPurelyCharacterSet(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"])
  }
  
  
  
  // ---------------
  // MARK: Conversion
  // ---------------
  public var double: Double? {
    if isFloatingPointNumber { return Double(self) }
    if isDollarAmount { return Double(components(separatedBy: "$").joined()) }
    return nil
  }
  public var float: Float? { if let double = double { return Float(double) } else { return nil } }
  public var uiColor: UIColor? {
    if !isHexCode { return nil }
    return UIColor(hex: self)
  }
  public func attributed (with textStyle: TextStyle?) -> NSMutableAttributedString {
    let attributes: [NSAttributedStringKey: Any] = [.foregroundColor: (textStyle?.textColor ?? .black) as Any, .font: (textStyle?.font ?? UIFont()) as Any, .kern: textStyle?.characterSpacing ?? 1]
    return NSMutableAttributedString(string: self, attributes: attributes)
  }
  
  
  // ---------------
  // MARK: Substring
  // ---------------
  public func decapitated () -> Substring {
    if count == 0 { return "" }
    return self[1...]
  }
  
  public func removing (_ substring: String) -> String {
    return self.components(separatedBy: substring).joined()
  }
  
  public var words: [String] { return self.split(separator: " ").map({ String($0) }) }
  
  // ---------------
  // MARK: Ranges
  // ---------------
  public func rangeIsValid (_ nsRange: NSRange) -> Bool {
    if nsRange.location == NSNotFound { return false }
    if nsRange.location + nsRange.length > NSString(string: self).length { return false }
    return true
  }
  
  
  // ------------------
  // MARK: JSON Object
  // ------------------
  public var jsonObject: Any? {
    guard let data = self.data(using: .utf8) else { return nil }
    do { return try JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0)) }
    catch { return nil }
  }
  
  
  // --------------------
  // MARK: Read/Write
  // --------------------
  public func writeTxtFileToDisk (_ filename: String) {
    guard let extensionlessFilename = filename.components(separatedBy: ".txt").first else { return }
    guard let data = self.data(using: String.Encoding.utf8) else { return }
    let filename = extensionlessFilename + ".txt"
    data.writeToDisk(filename: filename)
  }
  
  public static func readTxtFileFromBundle (_ fileName: String) -> String? {
    guard let extensionlessFileName = fileName.components(separatedBy: ".txt").first else { return nil }
    guard let filePath = Bundle.main.path(forResource: extensionlessFileName, ofType: "txt") else { return nil }
    guard let data = NSData(contentsOfFile: filePath) as Data? else { return nil }
    return String(data: data, encoding: .utf8)
  }
  
  public static func readTxtFileFromDisk (_ fileName: String) -> String? {
    guard let extensionlessFileName = fileName.components(separatedBy: ".txt").first else { return nil }
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(extensionlessFileName + ".txt")
    guard let data = NSData(contentsOf: fileURL) as Data? else { return nil }
    return String(data: data, encoding: .utf8)
  }
  
  
  // ---------------
  // MARK: Print
  // ---------------
  public func print () { Swift.print(self) }
}

