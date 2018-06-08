//
//  Label.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/29/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

// MARK: - Initial Declaration
open class Label: View {
  // Outlet
  public let textOutlet: TextVisualOutlet?
  
  // Non-Animatable Properties
  public var text: String = "" { willSet { textOutlet?.setText(newValue) } }
  public var textStyle: TextStyle = .default { willSet { textOutlet?.setTextStyle(newValue) } }
  
  // Init
  public init (textOutlet: TextVisualOutlet?) {
    self.textOutlet = textOutlet
    super.init(outlet: textOutlet)
  }
  
  public override init () {
    self.textOutlet = TextVisualOutletFactory.createNewTextOutlet()
    super.init(outlet: self.textOutlet)
  }
}
