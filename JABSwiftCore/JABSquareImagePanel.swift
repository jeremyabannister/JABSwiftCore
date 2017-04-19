//
//  JABSquareImagePanel.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/27/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

open class JABSquareImagePanel: JABPanel {

    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    
    // MARK: State
    open var image: UIImage?
    open var videoPath: URL?
    
    // MARK: UI
    open let imageViewMask = UIView()
    let imageView = UIImageView()
    
    // MARK: Parameters
    
    
    
    
    
    // **********************************************************************************************************************
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Init
    // MARK:
    
    override public init (frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        self.image = UIImage(named:"black.jpg")
        heightToWidthRatio = 1
    }
    
    public convenience init (image: UIImage?) {
        self.init(frame: CGRect.zero)
        self.image = image
        
    }
    
    public convenience init (videoPath: URL?) {
        self.init()
        self.videoPath = videoPath
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Should not be initializing from coder \(self)", terminator: "")
    }
    
    
    
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    
    // MARK: All
    override open func addAllUI() {
        
        addImageViewMask()
        addImageView()
        
    }
    
    override open func updateAllUI() {
        
        configureImageViewMask()
        positionImageViewMask()
        
        configureImageView()
        positionImageView()
        
    }
    
    
    
    // MARK: Adding
    func addImageViewMask () {
        addSubview(imageViewMask)
    }
    
    func addImageView () {
        imageViewMask.addSubview(imageView)
    }
    
    
    // MARK: Mask
    func configureImageViewMask () {
        
        imageViewMask.clipsToBounds = true
        
    }
    
    func positionImageViewMask () {
        
        imageViewMask.frame = relativeFrame
        
    }
    
    
    // MARK: Image View
    func configureImageView () {
        
        imageView.image = image
        
    }
    
    func positionImageView () {
        
        var newFrame = CGRect.zero
        
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
