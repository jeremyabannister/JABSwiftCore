//
//  JABImageButton.swift
//  Findr
//
//  Created by Jeremy Bannister on 8/11/17.
//  Copyright © 2017 Findr LLC. All rights reserved.
//

import UIKit

open class JABImageButton: JABButton {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    
    // MARK: State
    open var image: UIImage?
    open var tintColorForImage: UIColor?
    open var contentInset: CGFloat = 0
    
    open var pressedImage: UIImage?
    open var tintColorForPressedImage: UIColor?
    open var contentInsetForPressedImage: CGFloat?
    
    // MARK: UI
    fileprivate let imageView = UIImageView()
    fileprivate let pressedImageView = UIImageView()
    
    // MARK: Parameters
    
    
    
    
    
    // **********************************************************************************************************************
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public init () {
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Should not be initializing from coder \(self)")
    }
    
    override open func globalVariablesWereInitialized() {
        
        updateParameters()
        
    }
    
    
    // MARK: Parameters
    override open func updateParameters() {
        super.updateParameters()
        
        if iPad {
            
        }
        
    }
    
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    
    // MARK: All
    override open func addAllUI() {
        super.addAllUI()
        
        addImageView()
        addPressedImageView()
        
    }
    
    override open func updateAllUI() {
        
        super.updateAllUI()
        updateParameters()
        
        
        configureImageView()
        positionImageView()
        
        configurePressedImageView()
        positionPressedImageView()
        
    }
    
    
    // MARK: Adding
    fileprivate func addImageView () {
        addSubview(imageView)
    }
    
    fileprivate func addPressedImageView () {
        addSubview(pressedImageView)
    }
    
    
    
    
    
    
    // MARK: Image View
    fileprivate func configureImageView () {
        let view = imageView
        if let tint = tintColorForImage { view.image = image?.imageTintedWithColor(tint) }
        else { view.image = image }
        view.opacity = Float(1 - visualPressedExtent)
    }
    
    fileprivate func positionImageView () {
        guard let image = image else { return }
        if image.size.width == 0 || image.size.height == 0 || width == 0 || height == 0 { return }
        
        let view = imageView
        var newFrame = CGRect.zero
        
        let aspectRatio = self.width/self.height
        let imageAspectRatio = image.size.width/image.size.height
        
        if imageAspectRatio > aspectRatio {
            newFrame.size.width = width - 2*contentInset
            newFrame.size.height = newFrame.size.width / imageAspectRatio
        } else {
            newFrame.size.height = height - 2*contentInset
            newFrame.size.width = newFrame.size.height * imageAspectRatio
        }
        
        newFrame.origin.x = (width - newFrame.size.width)/2
        newFrame.origin.y = (height - newFrame.size.height)/2
        
        view.frame = newFrame
    }
    
    
    // MARK: Pressed Image View
    fileprivate func configurePressedImageView () {
        let view = pressedImageView
        let pressedImage = self.pressedImage ?? image
        if let tintColorForPressedImage = self.tintColorForPressedImage ?? self.tintColorForImage { view.image = pressedImage?.imageTintedWithColor(tintColorForPressedImage) }
        else { view.image = pressedImage }
        view.opacity = Float(visualPressedExtent)
    }
    
    fileprivate func positionPressedImageView () {
        if image == nil && pressedImage == nil { return }
        guard let pressedImage = self.pressedImage ?? self.image else { return }
        if pressedImage.size.width == 0 || pressedImage.size.height == 0 || width == 0 || height == 0 { return }
        
        let view = pressedImageView
        var newFrame = CGRect.zero
        
        let aspectRatio = self.width/self.height
        let imageAspectRatio = pressedImage.size.width/pressedImage.size.height
        let contentInsetForPressedImage = self.contentInsetForPressedImage ?? self.contentInset
        
        if imageAspectRatio > aspectRatio {
            newFrame.size.width = width - 2*contentInsetForPressedImage
            newFrame.size.height = newFrame.size.width / imageAspectRatio
        } else {
            newFrame.size.height = height - 2*contentInsetForPressedImage
            newFrame.size.width = newFrame.size.height * imageAspectRatio
        }
        
        newFrame.origin.x = (width - newFrame.size.width)/2
        newFrame.origin.y = (height - newFrame.size.height)/2
        
        view.frame = newFrame
    }
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
}
