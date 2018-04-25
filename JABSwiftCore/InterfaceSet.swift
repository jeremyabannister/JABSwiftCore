//
//  InterfaceSet.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/7/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

public protocol InterfaceSet {
  var elements: [InterfaceElementOld] { get }
}
public protocol InterfaceElementOld {
  var addableViews: [UIView] { get }
}
