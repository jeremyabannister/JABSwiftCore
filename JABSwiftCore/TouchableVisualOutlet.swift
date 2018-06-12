//
//  TouchableVisualOutlet.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/8/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public protocol TouchableVisualOutlet: VisualOutlet {
  func whenNewTouchLocationOccurs (_ callback: @escaping (Point, TouchEvent.State)->())
}
