//
//  iOSPassthroughVisualOutlet.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/20/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

class iOSPassthroughVisualOutlet: UIView, PassthroughVisualOutlet {
  override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let view = super.hitTest(point, with: event)
    return view == self ? nil : view
  }
}
