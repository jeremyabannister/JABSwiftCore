//
//  JABInterfaceSet.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/7/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

protocol JABInterfaceSet {
  var elements: [InterfaceElement] { get }
}

protocol InterfaceElement { var addableViews: [UIView] { get } }
extension UIView: InterfaceElement { var addableViews: [UIView] { return [self] } }
extension Array: InterfaceElement where Element == UIView { var addableViews: [UIView] { return self } }
