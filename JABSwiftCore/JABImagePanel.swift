//
//  JABImagePanel.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/24/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public class JABImagePanel: JABPanel {

    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    
    // MARK: State
    public var image: UIImage? {
        didSet {
            updateHeightToWidthRatio()
        }
    }
    
    // MARK: UI
    let imageView = UIImageView()
    
    // MARK: Parameters
    
    
    
    
    
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
    
    
    public convenience init (image: UIImage?) {
        
        self.init()
        
        self.image = image
        updateHeightToWidthRatio()
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        
        super.init()
        println("Should not be initializing from coder \(self)")
    }
    
    
    
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    
    // MARK: All
    override public func addAllUI() {
        
        addImageView()
        
    }
    
    override public func updateAllUI() {
        
        configureImageView()
        positionImageView()
        
    }
    
    
    
    // MARK: Adding
    func addImageView () {
        addSubview(imageView)
    }
    
    
    // MARK: Image View
    func configureImageView () {
        
        imageView.image = image
        
    }
    
    func positionImageView () {
        
        imageView.frame = relativeFrame
        
    }
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    // MARK: Maintainance
    func updateHeightToWidthRatio () {
        if image != nil {
            if image!.size.width != 0 {
                heightToWidthRatio = CGFloat(image!.size.height/image!.size.width)
            } else {
                heightToWidthRatio = CGFloat(1)
            }
        } else {
            heightToWidthRatio = CGFloat(1)
        }
    }
    
    
}
