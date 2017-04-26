//
//  JABStopwatch.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/25/17.
//  Copyright © 2017 Jeremy Bannister. All rights reserved.
//

import UIKit

public class JABStopwatch: NSObject {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    
    // MARK: Managers
    
    // MARK: State
    public var processes = [String: TimeInterval]()
    public var averageIdentifiersForProcesses = [String: String]()
    public var averages = [String: (TimeInterval, Int)]() // [averageIdentifier: (currentAverage, numberOfContibutorsToAverage)]
    
    
    // **********************************************************************************************************************
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public override init () {
        
        super.init()
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        
        super.init()
        
    }
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    // MARK: Processes
    public func startProcess (_ processIdentifier: String, addToAverage averageIdentifier: String? = nil) {
        if let averageIdentifier = averageIdentifier { averageIdentifiersForProcesses[processIdentifier] = averageIdentifier }
        processes[processIdentifier] = Date.timeIntervalSinceReferenceDate
    }
    
    public func endProcess (_ processIdentifier: String) {
        let currentTime = Date.timeIntervalSinceReferenceDate
        if processes[processIdentifier] != nil {
            let timeIntervalInSeconds = currentTime - processes[processIdentifier]!
            guard let averageIdentifier = averageIdentifiersForProcesses[processIdentifier] else {
                let timeIntervalString = String(format: "%.04f", timeIntervalInSeconds * 1000)
                print("\(processIdentifier) took \(timeIntervalString) ms")
                return
            }
            if averages[averageIdentifier] != nil {
                let currentNumberOfAveragedValues = averages[averageIdentifier]!.1
                let currentSum = averages[averageIdentifier]!.0 * Double(currentNumberOfAveragedValues)
                averages[averageIdentifier]!.1 = currentNumberOfAveragedValues + 1
                averages[averageIdentifier]!.0 = (currentSum + timeIntervalInSeconds)/Double(averages[averageIdentifier]!.1)
            } else {
                averages[averageIdentifier] = (timeIntervalInSeconds, 1)
            }
            averageIdentifiersForProcesses[processIdentifier] = nil
        }
        processes[processIdentifier] = nil
    }
    
    public func endAverage (_ averageIdentifier: String) {
        guard let averageTime = averages[averageIdentifier]?.0 else { return }
        let averageTimeString = String(format: "%.04f", averageTime * 1000)
        print("\(averageIdentifier) averaged \(averageTimeString) ms (sample size: \(averages[averageIdentifier]!.1))")
        averages[averageIdentifier] = nil
    }
    
    public func endAverages (_ averageIdentifiers: [String]) {
        for averageIdentifier in averageIdentifiers {
            endAverage(averageIdentifier)
        }
    }
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
}
