//
//  InterfaceNode.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/7/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation

public protocol InterfaceNode {
  var interface: [InterfaceProtocol] { get }
}
public extension InterfaceNode {
  func addUI () { interface.forEach({ $0.addInterfaceElements() }) }
  func updateUI () { interface.forEach({ $0.updateInterfaceElements() }) }
}
