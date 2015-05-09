//
//  Size.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/8/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public class Size {
    
    
    // MARK: Properties
    
    public var width = CGFloat(0) {
        didSet {
            if width < 0 {
                width = 0
            }
        }
    }
    
    public var height = CGFloat(0) {
        didSet {
            if height < 0 {
                height = 0
            }
        }
    }
    
    public var depth = CGFloat(0) {
        didSet {
            if depth < 0 {
                depth = 0
            }
        }
    }
    
    
    
    // MARK: Init
    public init (width: CGFloat, height: CGFloat, depth: CGFloat) {
        self.width = width
        self.height = height
        self.depth = depth
    }
    
    public convenience init () {
        self.init(width: 0, height: 0, depth: 0)
    }
    
}
