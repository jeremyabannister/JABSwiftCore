//
//  JABInterfaceNode.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/7/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation

public protocol JABInterfaceNode {
  var interfaceManagers: [JABInterfaceManager] { get }
}
public extension JABInterfaceNode {
  func addUI () { interfaceManagers.forEach({ $0.addInterfaceSet() }) }
  func updateUI () { interfaceManagers.forEach({ $0.updateInterfaceSet() }) }
}
