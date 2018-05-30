//
//  TextVisualOutletFactory.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/29/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

public class TextVisualOutletFactory {
  private init () { }
  public static func createNewTextOutlet () -> TextVisualOutlet { return UILabel() }
}


extension UILabel: TextVisualOutlet {
  public func setText (_ text: String) {
    self.text = text
  }
  
  public func setTextStyle (_ textStyle: TextStyle?) {
    self.textStyle = TextStyleForUILabel(textStyle)
  }
}
