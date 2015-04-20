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
    public var buttonDelegate: JABButtonDelegate?
    public var type = JABButtonType.Image
    public var pressed = false
    public var dimmed = false
    
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
                dimmedBackgroundColor = undimmedBackgroundColor?.dim(70)
            }
        }
    }
    public var dimmedBackgroundColor: UIColor?
    
    // Image
    public var image: UIImage?
    public var pressedImage: UIImage?
    
    // Text
    public var text = ""
    public var textAlignment = NSTextAlignment.Center
    public var textColor = UIColor.blackColor()
    public var font = UIFont(name: "HelveticaNeue-Medium", size: 12)
    
    
    // MARK: UI
    var imageView = UIImageView()
    var textLabel = UILabel()
    
    
    // MARK: Parameters
    public var horizontalContentInset: CGFloat = 0.0
    public var verticalContentInset: CGFloat = 0.0
    
    public var dimsWhenPressed = false
    
    
    
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
    
    required public init(coder aDecoder: NSCoder) {
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
    
    
    
    // MARK: Background
    func configureBackground () {
        
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
    
    
    
    // MARK: Image View
    func configureImageView () {
        
        
        if pressed {
            
            imageView.image = pressedImage
            
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
        textLabel.textColor = textColor
        textLabel.font = font
        
    }
    
    func positionTextLabel () {
        var newFrame = CGRectZero
        
        newFrame.origin.x = horizontalContentInset
        newFrame.origin.y = verticalContentInset
        
        newFrame.size.width = width - 2*horizontalContentInset
        newFrame.size.height = height - 2*verticalContentInset
        
        textLabel.frame = newFrame
        
    }
    
    
    
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Touch Manager
    override public func touchDidBegin(locationInParentView: CGPoint?, locationInView: CGPoint) {
        
        pressed = true
        updateAllUI()
        buttonDelegate?.buttonWasTouched(self)
        
    }
    
    override public func touchDidChange(locationInParentView: CGPoint?, locationInView: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        
        if relativeFrame.contains(locationInView) {
            
            pressed = true
            
        } else {
            
            pressed = false
            
        }
        
        updateAllUI()
        
    }
    
    override public func touchDidEnd(locationInParentView: CGPoint?, locationInView: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        
        if relativeFrame.contains(locationInView) {
            
            pressed = true
            
        } else {
            
            pressed = false
            
        }
        
        buttonDelegate?.buttonWasUntouched(self, triggered: pressed)
        
        pressed = false
        
        updateAllUI()
        
    }
    
    override public func touchDidCancel(locationInParentView: CGPoint?, locationInView: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        
        buttonDelegate?.buttonWasUntouched(self, triggered: false)
        pressed = false
        updateAllUI()
        
    }
    
    
    
}



public protocol JABButtonDelegate {
    
    func buttonWasTouched(button: JABButton)
    func buttonWasUntouched(button: JABButton, triggered: Bool)
    
}
