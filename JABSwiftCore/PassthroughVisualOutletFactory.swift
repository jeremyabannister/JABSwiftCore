//
//  PassthroughVisualOutletFactory.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/20/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

public class PassthroughVisualOutletFactory {
  private init () { }
  public static func createNewPassthroughOutlet () -> PassthroughVisualOutlet {
    return iOSPassthroughVisualOutlet()
  }
}
