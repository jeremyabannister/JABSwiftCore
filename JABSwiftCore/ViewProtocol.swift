//
//  ViewProtocol.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/23/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

//public protocol ViewProtocol {
//  var frame: Rect { get set }
//  var backgroundColor: Color { get set }
//  var cornerRadius: Double { get set }
//  var shadow: Shadow { get set }
//}


public protocol VisualOutlet {
  func setFrame (_ frame: Rect)
  func setBackgroundColor (_ backgroundColor: Color)
  func setCornerRadius (_ cornerRadius: Double)
  func setShadow (_ shadow: Shadow)
}
