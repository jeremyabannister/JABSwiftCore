//
//  TouchableVisualOutletFactory.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/8/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

public class TouchableVisualOutletFactory {
  private init () { }
  public static func createNewTouchableOutlet () -> TouchableVisualOutlet {
    return iOSTouchableVisualOutlet()
  }
}

extension iOSTouchableVisualOutlet: TouchableVisualOutlet {
  func whenNewTouchLocationOccurs (_ callback: @escaping (Point, TouchEvent.State) -> ()) {
    callbackForWhenNewTouchLocationOccurs = callback
  }
}
