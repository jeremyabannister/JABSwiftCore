//
//  JABGlobalVariables.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/11/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public var heightOfStatusBar = UIApplication.shared.statusBarFrame.size.height
public var staticOnScreenView: UIView?
public let partialSlideFraction = CGFloat(0.3)
public let thresholdDragDistance = CGFloat(90.0)
public let backPanTouchThreshold = CGFloat(25.0)

public let globalStopwatch = JABStopwatch()
public var currentDebugView = UIView()

public var rootViewController = UIViewController()


public func max<T: Comparable> (of value1: T, _ value2: T) -> T { return value1 > value2 ? value1 : value2 }
