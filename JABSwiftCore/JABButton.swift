//
//  JABButton.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/17/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public enum JABButtonType {
    case image
    case text
}

open class JABButton: JABTouchableView {
   
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: State
    // Button
    open var buttonDelegate: JABButtonDelegate? // The receiver of notifications from button
    open var type = JABButtonType.image
    fileprivate var pressed = false
    fileprivate var dimmed = false
    fileprivate var swollen = false
    
    // Frame
    override open var frame: CGRect {
        didSet {
            if !swollen {
                originalFrame = frame
            }
        }
    }
    var originalFrame = CGRect.zero
    
    // Background Color
    override open var backgroundColor: UIColor? {
        didSet {
            if !dimmed {
                undimmedBackgroundColor = backgroundColor
            }
        }
    }
    open var undimmedBackgroundColor: UIColor? {
        didSet {
            if dimmedBackgroundColor == nil {
                if undimmedBackgroundColor?.components.alpha == 0 {
                    dimmedBackgroundColor = UIColor(white: 0, alpha: 0.2)
                } else {
                    dimmedBackgroundColor = undimmedBackgroundColor?.dim(0.7)
                }
            }
        }
    }
    open var dimmedBackgroundColor: UIColor? = UIColor(white: 0, alpha: 0.2)
    
    // Image
    open var image: UIImage?
    open var pressedImage: UIImage?
    
    // Text
    open var text = ""
    open var textAlignment = NSTextAlignment.center
    open var font = UIFont(name: "HelveticaNeue-Medium", size: 12)
    
    // Text Color
    open var textColor = UIColor.black {
        didSet {
            if !dimmed {
                undimmedTextColor = textColor
            }
        }
    }
    open var undimmedTextColor: UIColor? {
        didSet {
            if dimmedTextColor == nil {
                if undimmedTextColor != blackColor {
                    dimmedTextColor = undimmedTextColor?.dim(0.7)
                } else {
                    dimmedTextColor = UIColor(white: 0.3, alpha: 1)
                }
                
            }
        }
    }
    open var dimmedTextColor: UIColor?
    
    
    // MARK: UI
    fileprivate let imageView = UIImageView()
    fileprivate let textLabel = UILabel()
    
    
    // MARK: Parameters
    open var horizontalContentInset: CGFloat = 0.0
    open var verticalContentInset: CGFloat = 0.0
    
    open var dimsWhenPressed = false
    open var textButtonDimsBackground = false
    open var swellsWhenPressed = false
    open var swellFraction = CGFloat(1.1)
    open var swellDuration = 0.2
    
    
    
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
    
    required public init?(coder aDecoder: NSCoder) {
        super.init()
    }
    
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    // MARK: All
    override open func addAllUI () {
        
        addImageView()
        addTextLabel()
        
    }
    
    override open func updateAllUI() {
        
        configureSize()
        configureBackground()
        
        configureImageView()
        positionImageView()
        
        configureTextLabel()
        positionTextLabel()
        
    }
    
    
    // MARK: Adding
    func addImageView () {
        addSubview(imageView)
    }
    
    func addTextLabel () {
        addSubview(textLabel)
    }
    
    
    // MARK: Size
    func configureSize () {
        
        if swellsWhenPressed {
            if pressed {
                if !swollen {
                    setSwollen(true, animated: false)
                }
            } else {
                if swollen {
                    setSwollen(false, animated: false)
                }
            }
        }
        
    }
    
    
    // MARK: Background
    func configureBackground () {
        
        if type == JABButtonType.image || textButtonDimsBackground {
            if dimsWhenPressed {
                if pressed {
                    if !dimmed {
                        dimmed = true
                        backgroundColor = dimmedBackgroundColor
                    }
                } else {
                    if dimmed {
                        dimmed = false
                        backgroundColor = undimmedBackgroundColor
                    }
                }
            }
        }
        
    }
    
    
    
    // MARK: Image View
    func configureImageView () {
        
        
        if pressed {
            
            if let verifiedPressedImage = pressedImage {
                imageView.image = verifiedPressedImage
            }
            
        } else {
            
            imageView.image = image
            
        }
        
        
        
        switch type {
            
        case JABButtonType.image:
            
            imageView.opacity = 1
            
        case JABButtonType.text:
            
            imageView.opacity = 0
            
        }
        
    }
    
    func positionImageView () {
        
        var newFrame = CGRect.zero
        
        newFrame.origin.x = horizontalContentInset
        newFrame.origin.y = verticalContentInset
        
        newFrame.size.width = width - 2*horizontalContentInset
        newFrame.size.height = height - 2*verticalContentInset
        
        imageView.frame = newFrame
        
    }
    
    
    // MARK: Text Label
    func configureTextLabel () {
        
        textLabel.text = text
        textLabel.textAlignment = textAlignment
        textLabel.font = font
        
        if !textButtonDimsBackground {
            if dimsWhenPressed {
                if pressed {
                    dimmed = true
                    textLabel.textColor = dimmedTextColor
                } else {
                    dimmed = false
                    textLabel.textColor = undimmedTextColor
                }
            } else if swellsWhenPressed {
                textLabel.textColor = textColor
            }
        } else {
            textLabel.textColor = textColor
        }
        
    }
    
    func positionTextLabel () {
        if let text = textLabel.text {
            
            var newFrame = CGRect.zero
            let size = textLabel.font.sizeOfString(text, constrainedToWidth: 0)
            
            newFrame.size.width = size.width
            newFrame.size.height = size.height
            
            newFrame.origin.x = (width - newFrame.size.width)/2
            newFrame.origin.y = (height - newFrame.size.height)/2
            
            textLabel.frame = newFrame
        }
    }
    
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    func setSwollen(_ isSwollen: Bool, animated: Bool) {
        
        swollen = isSwollen
        
        var newFrame = CGRect.zero
        if isSwollen {
            
            newFrame.size.width = originalFrame.size.width * swellFraction
            newFrame.size.height = originalFrame.size.height * swellFraction
            
            newFrame.origin.x = originalFrame.origin.x - (newFrame.size.width - originalFrame.size.width)/2
            newFrame.origin.y = originalFrame.origin.y - (newFrame.size.height - originalFrame.size.height)/2
        
        } else {
            newFrame = originalFrame
        }
        
        if animated {
            UIView.animate(withDuration: swellDuration, animations: { () -> Void in
                self.frame = newFrame
            })
        } else {
            frame = newFrame
        }
    }
    
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Touch Manager
    override open func touchDidBegin(_ gestureRecognizer: UIGestureRecognizer) {
        pressed = true
        animatedUpdate(0.1) { (Bool) -> () in
            
        }
        buttonDelegate?.buttonWasTouched(self)
        
    }
    
    override open func touchDidChange(_ gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        if relativeFrame.contains(gestureRecognizer.location(in: self)) {
            pressed = true
        } else {
            pressed = false
        }
        
        animatedUpdate(0.1) { (Bool) -> () in
            
        }
        
    }
    
    override open func touchDidEnd(_ gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        if relativeFrame.contains(gestureRecognizer.location(in: self)) {
            pressed = true
        } else {
            pressed = false
        }
        
        buttonDelegate?.buttonWasUntouched(self, triggered: pressed)
        pressed = false
        animatedUpdate(0.1) { (Bool) -> () in
            
        }
    }
    
    override open func touchDidCancel(_ gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        buttonDelegate?.buttonWasUntouched(self, triggered: false)
        pressed = false
        animatedUpdate(0.1) { (Bool) -> () in
            
        }
        
    }
    
    
    
}



public protocol JABButtonDelegate {
    
    func buttonWasTouched(_ button: JABButton)
    func buttonWasUntouched(_ button: JABButton, triggered: Bool)
    
}
