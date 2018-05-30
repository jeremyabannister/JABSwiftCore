//
//  Font-Family.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/29/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

// MARK: - Initial Declaration
public extension Font {
  public enum Family {
    case sanFrancisco
    case other(String)
  }
}

// MARK: - Static Members
public extension Font.Family {
  public static var `default`: Font.Family { return .sanFrancisco }
}

// MARK: - Name String
public extension Font.Family {
  public var nameString: String {
    switch self {
    case .sanFrancisco: return ".SFUIText"
    case .other(let name): return name
    }
  }
}
