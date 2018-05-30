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
  
  // Init
  public init (size: Double, family: Font.Family, weight: Font.Weight = .normal) {
    self.size = size
    self.family = family
    self.weight = weight
  }
}

public extension Font {
  public var fontNameString: String { return family.nameString }
}
