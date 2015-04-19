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
//    public var delegate: JABButtonDelegate?
    public var type = JABButtonType.Image
    public var pressed = false
    
    public var dimmedBackgroundColor: UIColor?
    override public var backgroundColor: UIColor? {
        didSet {
            if dimmedBackgroundColor == nil {
                dimmedBackgroundColor = backgroundColor?.dim(70)
            }
        }
    }
    
    public var image = UIImage()
    public var pressedImage = UIImage()
    
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
        
        imageView.frame = frame
        
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
        
        textLabel.frame = frame
        
    }
    
    
    
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Touch Manager
    override public func touchDidBegin(locationOnScreen: CGPoint, locationInView: CGPoint) {
        
        pressed = true
        updateAllUI()
//        delegate?.buttonWasTouched(self)
        
    }
    
    override public func touchDidChange(locationOnScreen: CGPoint, locationInView: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        
        
        
    }
    
    override public func touchDidEnd(locationOnScreen: CGPoint, locationInView: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        
    }
    
    override public func touchDidCancel(locationOnScreen: CGPoint, locationInView: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        
    }
    
    
    
}



public protocol JABButtonDelegate: JABTouchableViewDelegate {
    
    func buttonWasTouched(button: JABButton)
    func buttonTouchLocationChanged(button: JABButton, locationOnScreen: CGPoint, locationInButton: CGPoint)
    func buttonTouchEnded(button: JABButton, locationOnScreen: CGPoint, locationInButton: CGPoint, pressed: Bool)
    
}
