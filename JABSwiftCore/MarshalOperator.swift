//
//  MarshalOperator.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 8/8/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation

// This is the operator definition that should be placed in your app. I like to place it above the "class ViewController: UIViewController {" line of my main view controller
// infix operator ~> {}

/** Serial dispatch queue used by the ~> operator. */
private let queue = dispatch_queue_create("serial-worker", DISPATCH_QUEUE_SERIAL)

/**
Executes the lefthand closure on a background thread and,
upon completion, the righthand closure on the main thread.
*/
public func ~> (backgroundClosure: () -> (),
         mainClosure:       () -> ())
{
    dispatch_async(queue) {
        backgroundClosure()
        dispatch_async(dispatch_get_main_queue(), mainClosure)
    }
}
