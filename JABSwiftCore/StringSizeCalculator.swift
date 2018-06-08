//
//  StringSizeCalculator.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/8/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public protocol StringSizeCalculator {
  func size (of string: String, constrainedToWidth width: Double?, usingFont font: Font) -> Size
}
