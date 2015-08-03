//
//  JABApplicationRoot.swift
//  Party Hop
//
//  Created by Jeremy Bannister on 4/10/15.
//  Copyright (c) 2015 Bard App Team. All rights reserved.
//

import Foundation

public class JABApplicationRoot: JABView, JABLocationTesterDelegate {
    
    
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: State
    
    // MARK: UI
    private let locationTester = JABLocationTester()
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public override init () {
        super.init()
        
        staticOnScreenView = self
        initializeGlobalParameters()
        
        locationTester.locationTesterDelegate = self
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init()
    }
    
    
    // MARK:
    // MARK: Debug
    // MARK:
    
    public func launchLocationTesterAfterDelay (delay: NSTimeInterval) {
        
        NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: "launchLocationTester", userInfo: nil, repeats: false)
        
    }
    
    public func launchLocationTester () {
        
        locationTester.frame = relativeFrame
        addSubview(locationTester)
        
    }
    
    public func cancelLocationTester () {
        
        locationTester.removeFromSuperview()
        
    }
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Location Tester
    public func locationTesterDelegateDidCancel() {
        cancelLocationTester()
    }
    
    
}
