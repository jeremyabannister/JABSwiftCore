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
    public enum MorphState { case image, hidden }
    open private(set) var morphState: MorphState
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
    
    public init (morphState: MorphState = .image) {
        self.morphState = morphState
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.morphState = .image
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
        var newSite = CGRect.zero
        
        let aspectRatio = self.width/self.height
        let imageAspectRatio = image.size.width/image.size.height
        
        if imageAspectRatio > aspectRatio {
            newSite.size.width = width - 2*contentInset
            newSite.size.height = newSite.size.width / imageAspectRatio
        } else {
            newSite.size.height = height - 2*contentInset
            newSite.size.width = newSite.size.height * imageAspectRatio
        }
        
        if morphState == .hidden { newSite.size.height = 0.0001; newSite.size.width = newSite.size.height * imageAspectRatio }
        
        newSite.origin.x = (width - newSite.size.width)/2
        newSite.origin.y = (height - newSite.size.height)/2
        
        view.site = newSite
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
        var newSite = CGRect.zero
        
        let aspectRatio = self.width/self.height
        let imageAspectRatio = pressedImage.size.width/pressedImage.size.height
        let contentInsetForPressedImage = self.contentInsetForPressedImage ?? self.contentInset
        
        if imageAspectRatio > aspectRatio {
            newSite.size.width = width - 2*contentInsetForPressedImage
            newSite.size.height = newSite.size.width / imageAspectRatio
        } else {
            newSite.size.height = height - 2*contentInsetForPressedImage
            newSite.size.width = newSite.size.height * imageAspectRatio
        }
        
        if morphState == .hidden { newSite.size.height = 0.0001; newSite.size.width = newSite.size.height * imageAspectRatio }
        
        newSite.origin.x = (width - newSite.size.width)/2
        newSite.origin.y = (height - newSite.size.height)/2
        
        view.site = newSite
    }
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    // MARK: Morph State
    open func morph (to morphState: MorphState, animationDuration: TimeInterval = defaultAnimationDuration, completion: @escaping (Bool) -> () = { (completed) in }) {
        if self.morphState == morphState { return }
        self.morphState = morphState
        if animationDuration == 0 { updateAllUI(); completion(true) } else { animatedUpdate(duration: animationDuration, completion: completion) }
    }
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
}

