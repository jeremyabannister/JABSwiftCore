//
//  iOSTextVisualOutlet.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/20/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

class iOSTextVisualOutlet: UILabel { }

extension UILabel: TextVisualOutlet {
  public func setText (_ text: String) {
    self.text = text
  }
  
  public func setTextStyle (_ textStyle: TextStyle?) {
    self.textStyle = TextStyleForUILabel(textStyle)
  }
}
