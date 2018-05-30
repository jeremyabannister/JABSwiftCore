//
//  Font-Weight.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/29/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

// MARK: - Initial Declaration
public extension Font {
  public enum Weight {
    case normal
    case semibold
    case bold
  }
}

// MARK: - Suffix String
public extension Font.Weight {
  public var suffixString: String {
    switch self {
      case .normal: return ""
      case .semibold: return "-Semibold"
      case .bold: return "-Bold"
    }
  }
}
