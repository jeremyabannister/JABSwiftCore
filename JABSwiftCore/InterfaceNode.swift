//
//  InterfaceNode.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/7/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation

public protocol InterfaceNode {
  var interfaces: [InterfaceProtocol] { get }
}
public extension InterfaceNode {
  func addUI () { interfaces.forEach({ $0.addInterfaceElements() }) }
  func updateUI () { interfaces.forEach({ $0.updateInterfaceElements() }) }
}
