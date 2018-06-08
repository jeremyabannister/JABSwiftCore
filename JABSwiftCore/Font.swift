//
//  Font.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/29/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

// MARK: - Initial Declaration
public struct Font {
  // Properties
  public var size: Double
  public var family: Font.Family
  public var weight: Font.Weight
  public var characterSpacing: Double
  public var lineHeightMultiple: Double
  
  // Init
  public init (size: Double, family: Font.Family, weight: Font.Weight = .normal, characterSpacing: Double = 1, lineHeightMultiple: Double = 1) {
    self.size = size
    self.family = family
    self.weight = weight
    self.characterSpacing = characterSpacing
    self.lineHeightMultiple = lineHeightMultiple
  }
}

public extension Font {
  public static let defaultSize: Double = 12
  public static let `default`: Font = Font(size: Font.defaultSize, family: .default)
}

public extension Font {
  public var fontNameString: String { return family.nameString + weight.suffixString }
  public func size (of string: String, constrainedToWidth width: Double?) -> Size {
    return PlatformTools.stringSizeCalculator.size(of: string, constrainedToWidth: width, usingFont: self)
  }
}

public extension String {
  public func size (usingFont font: Font, constrainedToWidth width: Double?) -> Size {
    return PlatformTools.stringSizeCalculator.size(of: self, constrainedToWidth: width, usingFont: font)
  }
}
