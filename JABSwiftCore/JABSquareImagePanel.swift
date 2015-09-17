//
//  JABSquareImagePanel.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/27/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public class JABSquareImagePanel: JABPanel {

    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    
    // MARK: State
    public var image: UIImage?
    
    // MARK: UI
    let mask = UIView()
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
        
        heightToWidthRatio = 1
        
    }
    
    public convenience init (image: UIImage?) {
        
        self.init()
        
        self.image = image
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init()
        print("Should not be initializing from coder \(self)", terminator: "")
    }
    
    
    
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    
    // MARK: All
    override public func addAllUI() {
        
        addMask()
        addImageView()
        
    }
    
    override public func updateAllUI() {
        
        configureMask()
        positionMask()
        
        configureImageView()
        positionImageView()
        
    }
    
    
    
    // MARK: Adding
    func addMask () {
        addSubview(mask)
    }
    
    func addImageView () {
        mask.addSubview(imageView)
    }
    
    
    // MARK: Mask
    func configureMask () {
        
        mask.clipsToBounds = true
        
    }
    
    func positionMask () {
        
        mask.frame = relativeFrame
        
    }
    
    
    // MARK: Image View
    func configureImageView () {
        
        imageView.image = image
        
    }
    
    func positionImageView () {
        
        var newFrame = CGRectZero
        
        if let verifiedImage = image {
            if verifiedImage.size.width != 0 && verifiedImage.size.height != 0 {
                if verifiedImage.size.height > verifiedImage.size.width {
                    
                    newFrame.size.width = width
                    newFrame.size.height = (verifiedImage.size.height/verifiedImage.size.width) * width
                    
                    newFrame.origin.x = (width - newFrame.size.width)/2
                    newFrame.origin.y = (height - newFrame.size.height)/2
                    
                    imageView.frame = newFrame
                    
                } else {
                    
                    newFrame.size.height = height
                    newFrame.size.width = (verifiedImage.size.width/verifiedImage.size.height) * height
                    
                    newFrame.origin.x = (width - newFrame.size.width)/2
                    newFrame.origin.y = (height - newFrame.size.height)/2
                    
                    imageView.frame = newFrame
                    
                }
            } else {
                imageView.frame = relativeFrame
            }
        } else {
            imageView.frame = relativeFrame
        }
        
    }
}
