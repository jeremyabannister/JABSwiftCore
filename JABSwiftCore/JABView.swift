//
//  JABView.swift
//  Party Hop
//
//  Created by Jeremy Bannister on 4/10/15.
//  Copyright (c) 2015 Bard App Team. All rights reserved.
//

import Foundation
import UIKit


public class JABView: UIView {
    
    
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    
    override public var frame: CGRect {
        didSet {
            var scaled = false
            
            if ( (self.frame.size.width != oldValue.size.width) || (self.frame.size.height != oldValue.size.height) ) {
                scaled = true
            }
            
            if scaled {
                updateAllUI()
            }
        }
    }
    
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public init () {
        super.init(frame:CGRectZero)
        
        addAllUI()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    public func addAllUI () {
        
    }
    
    public func updateAllUI () {
        
    }
    
    public func animatedUpdate (duration: NSTimeInterval = 0.3) {
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.updateAllUI()
        })
    }
    
    
}
