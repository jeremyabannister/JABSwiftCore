//
//  TextVisualOutlet.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/29/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public protocol TextVisualOutlet: VisualOutlet {
  func setText (_ text: String)
  func setTextStyle (_ textStyle: TextStyle?)
}
