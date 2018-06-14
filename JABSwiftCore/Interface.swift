//
//  Interface.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/6/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public protocol Interface {
  var interfaceElements: [View?] { get }
  func addUI ()
  func updateUI ()
}

public extension Interface where Self: View {
  func addUI () {
    interfaceElements.forEach({ if let view = $0 { addSubview(view) } })
  }
}
