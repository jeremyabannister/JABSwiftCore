//
//  JABPassthroughView.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/9/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

public class JABPassthroughView: UIView {
  override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let view = super.hitTest(point, with: event)
    return view == self ? nil : view
  }
}
