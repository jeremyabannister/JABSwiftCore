//
//  JABButton.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/17/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

enum JABButtonType {
    case Image
    case Text
}

public class JABButton: JABTouchableView {
   
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: State
    var type = JABButtonType.Image
    var pressed = false
    
    var image = UIImage()
    
    var text = ""
    var textAlignment = NSTextAlignment.Center
    var textColor = UIColor.blackColor()
    var font = UIFont(name: "HelveticaNeue-Medium", size: 12)
    
    
    // MARK: UI
    var imageView = UIImageView()
    var textLabel = UILabel()
    
    
    // MARK: Parameters
    var horizontalContentInset: CGFloat = 0.0
    var verticalContentInset: CGFloat = 0.0
    
    var dimsWhenPressed = false
    
    
    
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
    
    
    
    // MARK: Image View
    func configureImageView () {
        
        imageView.image = image
        
        
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
        
    }
    
    override public func touchDidChange(locationOnScreen: CGPoint, locationInView: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        
    }
    
    override public func touchDidEnd(locationOnScreen: CGPoint, locationInView: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        
    }
    
    override public func touchDidCancel(locationOnScreen: CGPoint, locationInView: CGPoint, xDistance: CGFloat, yDistance: CGFloat, methodCallNumber: Int) {
        
    }
    
    
    
}
