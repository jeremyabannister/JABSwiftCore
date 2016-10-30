//
//  JABGlobalVariables.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/11/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public var globalVariablesInitialized = false
public var globalVariableInitializationNotificationSubscribers = [GlobalVariablesInitializationNotificationSubscriber]()
public var iPad = false
public let heightOfStatusBar = CGFloat(20.0)
public var staticOnScreenView: UIView?
public let partialSlideFraction = CGFloat(0.3)
public let thresholdDragDistance = CGFloat(90.0)
public let backPanTouchThreshold = CGFloat(25.0)

public var rootViewController = UIViewController()

public let redColor = UIColor.red
public let blueColor = UIColor.blue
public let greenColor = UIColor.green
public let yellowColor = UIColor.yellow
public let purpleColor = UIColor.purple
public let orangeColor = UIColor.orange
public let cyanColor = UIColor.cyan
public let whiteColor = UIColor.white
public let blackColor = UIColor.black
public let lightGrayColor = UIColor.lightGray
public let darkGrayColor = UIColor.darkGray
public let clearColor = UIColor.clear


// MATH
public let pi = 3.14159




public func initializeGlobalParameters () {
    
    if UIDevice.current.model == "iPad" {
        iPad = true
    }
    
    globalVariablesInitialized = true
    for subscriber in globalVariableInitializationNotificationSubscribers {
        subscriber.globalVariablesWereInitialized()
    }
    
}


public func indexOfA(_ object: AnyObject, array: [AnyObject]) -> Int? {
    for i in 0..<array.count {
        if array[i] === object {
            return i
        }
    }
    return nil
}



public protocol GlobalVariablesInitializationNotificationSubscriber {
    func globalVariablesWereInitialized ()
}
