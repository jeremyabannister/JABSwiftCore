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
  public static func createNewTextOutlet () -> TextVisualOutlet {
    return iOSTextVisualOutlet()
  }
}
