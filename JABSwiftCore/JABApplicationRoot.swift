//
//  JABApplicationRoot.swift
//  Party Hop
//
//  Created by Jeremy Bannister on 4/10/15.
//  Copyright (c) 2015 Bard App Team. All rights reserved.
//

import Foundation

public class JABApplicationRoot: JABView {
    
    
    
    // **********************************************************************************************************************
    
    
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
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init()
    }
    
    
}
