//
//  VisualOutletFactory.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/28/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

public class VisualOutletFactory {
  private init () { }
  public static func createNewOutlet () -> VisualOutlet { return UIView() }
}
