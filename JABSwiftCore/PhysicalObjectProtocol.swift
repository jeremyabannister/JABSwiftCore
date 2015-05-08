//
//  PhysicalObjectProtocol.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/8/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation


public protocol PhysicalObject {
    
    // MARK: State
    var isBeingHeld: Bool { get set }
    
    var position: CGPoint { get set }
    var dimensions: CGSize { get set }
    var velocity: CGPoint { get set }
    var mass: CGFloat { get set }
    var charge: CGFloat { get set }
    
}