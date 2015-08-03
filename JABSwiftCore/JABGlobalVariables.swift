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

public let redColor = UIColor.redColor()
public let blueColor = UIColor.blueColor()
public let greenColor = UIColor.greenColor()
public let yellowColor = UIColor.yellowColor()
public let purpleColor = UIColor.purpleColor()
public let orangeColor = UIColor.orangeColor()
public let cyanColor = UIColor.cyanColor()
public let whiteColor = UIColor.whiteColor()
public let blackColor = UIColor.blackColor()
public let lightGrayColor = UIColor.lightGrayColor()
public let darkGrayColor = UIColor.darkGrayColor()
public let clearColor = UIColor.clearColor()


// MATH
public let pi = 3.14159




public func initializeGlobalParameters () {
    
    if UIDevice.currentDevice().model == "iPad" {
        iPad == true
    }
    
    globalVariablesInitialized = true
    for subscriber in globalVariableInitializationNotificationSubscribers {
        subscriber.globalVariablesWereInitialized()
    }
    
}


public func indexOfA(object: AnyObject, array: [AnyObject]) -> Int? {
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