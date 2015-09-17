//
//  JABButton.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/17/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public enum JABButtonType {
    case Image
    case Text
}

public class JABButton: JABTouchableView {
   
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: State
    // Button
    public var buttonDelegate: JABButtonDelegate? // The receiver of notifications from button
    public var type = JABButtonType.Image
    private var pressed = false
    private var dimmed = false
    private var swollen = false
    
    // Frame
    override public var frame: CGRect {
        didSet {
            if !swollen {
                originalFrame = frame
            }
        }
    }
    var originalFrame = CGRectZero
    
    // Background Color
    override public var backgroundColor: UIColor? {
        didSet {
            if !dimmed {
                undimmedBackgroundColor = backgroundColor
            }
        }
    }
    public var undimmedBackgroundColor: UIColor? {
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
    public var dimmedBackgroundColor: UIColor? = UIColor(white: 0, alpha: 0.2)
    
    // Image
    public var image: UIImage?
    public var pressedImage: UIImage?
    
    // Text
    public var text = ""
    public var textAlignment = NSTextAlignment.Center
    public var font = UIFont(name: "HelveticaNeue-Medium", size: 12)
    
    // Text Color
    public var textColor = UIColor.blackColor() {
        didSet {
            if !dimmed {
                undimmedTextColor = textColor
            }
        }
    }
    public var undimmedTextColor: UIColor? {
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
    public var dimmedTextColor: UIColor?
    
    
    // MARK: UI
    private let imageView = UIImageView()
    private let textLabel = UILabel()
    
    
    // MARK: Parameters
    public var horizontalContentInset: CGFloat = 0.0
    public var verticalContentInset: CGFloat = 0.0
    
    public var dimsWhenPressed = false
    public var textButtonDimsBackground = false
    public var swellsWhenPressed = false
    public var swellFraction = CGFloat(1.1)
    public var swellDuration = 0.2
    
    
    
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
    override public func addAllUI () {
        
        addImageView()
        addTextLabel()
        
    }
    
    override public func updateAllUI() {
        
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
        
        if type == JABButtonType.Image || textButtonDimsBackground {
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
            
        case JABButtonType.Image:
            
            imageView.opacity = 1
            
        case JABButtonType.Text:
            
            imageView.opacity = 0
            
        default:
            imageView.opacity = 1
        }
        
    }
    
    func positionImageView () {
        
        var newFrame = CGRectZero
        
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
            
            var newFrame = CGRectZero
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
    
    func setSwollen(isSwollen: Bool, animated: Bool) {
        
        swollen = isSwollen
        
        var newFrame = CGRectZero
        if isSwollen {
            
            newFrame.size.width = originalFrame.size.width * swellFraction
            newFrame.size.height = originalFrame.size.height * swellFraction
            
            newFrame.origin.x = originalFrame.origin.x - (newFrame.size.width - originalFrame.size.width)/2
            newFrame.origin.y = originalFrame.origin.y - (newFrame.size.height - originalFrame.size.height)/2
        
        } else {
            newFrame = originalFrame
        }
        
        if animated {
            UIView.animateWithDuration(swellDuration, animations: { () -> Void in
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
    override public func touchDidBegin(gestureRecognizer: UIGestureRecognizer) {
        pressed = true
        animatedUpdate(0.1) { (Bool) -> () in
            
        }
        buttonDelegate?.buttonWasTouched(self)
        
    }
    
    override public func touchDidChange(gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        if relativeFrame.contains(gestureRecognizer.locationInView(self)) {
            pressed = true
        } else {
            pressed = false
        }
        
        animatedUpdate(0.1) { (Bool) -> () in
            
        }
        
    }
    
    override public func touchDidEnd(gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        if relativeFrame.contains(gestureRecognizer.locationInView(self)) {
            pressed = true
        } else {
            pressed = false
        }
        
        buttonDelegate?.buttonWasUntouched(self, triggered: pressed)
        pressed = false
        animatedUpdate(0.1) { (Bool) -> () in
            
        }
    }
    
    override public func touchDidCancel(gestureRecognizer: UIGestureRecognizer, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        buttonDelegate?.buttonWasUntouched(self, triggered: false)
        pressed = false
        animatedUpdate(0.1) { (Bool) -> () in
            
        }
        
    }
    
    
    
}



public protocol JABButtonDelegate {
    
    func buttonWasTouched(button: JABButton)
    func buttonWasUntouched(button: JABButton, triggered: Bool)
    
}
