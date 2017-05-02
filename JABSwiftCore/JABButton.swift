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
                if oldValue != backgroundColor { dimmedBackgroundColor = nil }
                undimmedBackgroundColor = backgroundColor
            }
        }
    }
    open var undimmedBackgroundColor: UIColor? {
        didSet {
            if dimmedBackgroundColor == nil {
                if undimmedBackgroundColor?.components.alpha == 0 || undimmedBackgroundColor == nil {
                    dimmedBackgroundColor = UIColor(white: 0, alpha: 1 - dimFraction)
                } else {
                    dimmedBackgroundColor = undimmedBackgroundColor?.dim(dimFraction)
                }
            }
        }
    }
    open var dimmedBackgroundColor: UIColor?
    
    // Image
    open var image: UIImage?
    open var pressedImage: UIImage?
    open var imageViewTransform: CGAffineTransform?
    
    // Text
    open var text = ""
    open var textAlignment = NSTextAlignment.center
    open var font = UIFont(name: "HelveticaNeue-Medium", size: 12)
    open var numberOfLines: Int?
    open var maximumWidthForTextLabel: CGFloat?
    
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
                    dimmedTextColor = undimmedTextColor?.dim(dimFraction)
                } else {
                    dimmedTextColor = UIColor(white: 1 - dimFraction, alpha: 1)
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
    
    open var dimsWhenPressed = true
    open var dimFraction: CGFloat = 0.8
    open var dimDuration: TimeInterval = 0.05
    open var dimDelay: TimeInterval?
    open var waitingForDimDelay = false
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
    
    override public init (frame: CGRect = CGRect.zero, shouldAddAllUI: Bool = true) {
        super.init(frame: frame, shouldAddAllUI: shouldAddAllUI)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        
        if undimmedBackgroundColor == nil {
            let currentBackgroundColor = backgroundColor
            backgroundColor = currentBackgroundColor
        }
        
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
        let view = imageView
        if pressed {
            if let verifiedPressedImage = pressedImage { imageView.image = verifiedPressedImage }
        } else {
            imageView.image = image
        }
        
        switch type {
        case JABButtonType.image:
            view.opacity = 1
        case JABButtonType.text:
            view.opacity = 0
        }
        
    }
    
    func positionImageView () {
        let view = imageView
        var newFrame = CGRect.zero
        
        newFrame.origin.x = horizontalContentInset
        newFrame.origin.y = verticalContentInset
        
        newFrame.size.width = width - 2*horizontalContentInset
        newFrame.size.height = height - 2*verticalContentInset
        
        if let transform = imageViewTransform {
            view.transform = transform
        } else {
            view.transform = CGAffineTransform.identity
            view.frame = newFrame
        }
    }
    
    
    // MARK: Text Label
    func configureTextLabel () {
        
        textLabel.text = text
        textLabel.textAlignment = textAlignment
        textLabel.font = font
        
        if numberOfLines != nil {
            textLabel.numberOfLines = numberOfLines!
        }
        
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
            var size = textLabel.font.sizeOfString(text, constrainedToWidth: 0)
            if let maxWidth = maximumWidthForTextLabel {
                size = textLabel.font.sizeOfString(text, constrainedToWidth: maxWidth)
            }
            
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
    
    
    
    
    open func cancelTouch () {
        touchManager?.cancelTouch()
    }
    
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Touch Manager
    override open func touchDidBegin(_ touchManager: JABTouchManager) {
        pressed = true
        if dimDelay != nil {
            waitingForDimDelay = true
            DispatchQueue.main.asyncAfter(deadline: .now() + dimDelay!) { self.waitingForDimDelay = false; self.animatedUpdate(self.dimDuration) { (Bool) -> () in } }
        } else {
            animatedUpdate(dimDuration) { (Bool) -> () in }
        }
        buttonDelegate?.buttonWasTouched(self)
    }
    
    override open func touchDidChange(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        guard let touchRecognizer = touchManager.touchRecognizer else { return }
        let oldPressed = pressed
        if bounds.contains(touchRecognizer.location(in: self)) {
            pressed = true
        } else {
            pressed = false
        }
        
        if pressed != oldPressed {
            animatedUpdate(dimDuration) { (Bool) -> () in }
        }
        
    }
    
    override open func touchDidEnd(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        guard let touchRecognizer = touchManager.touchRecognizer else { return }
        var triggered = false
        if bounds.contains(touchRecognizer.location(in: self)) {
            triggered = true
        }
        
        if waitingForDimDelay {
            pressed = true
            animatedUpdate(dimDuration) { (Bool) -> () in self.pressed = false; self.animatedUpdate(self.dimDuration) { (Bool) -> () in } }
        } else {
            pressed = false
            animatedUpdate(dimDuration) { (Bool) -> () in }
        }
        
        buttonDelegate?.buttonWasUntouched(self, triggered: triggered)
    }
    
    override open func touchDidCancel(_ touchManager: JABTouchManager, xDistance: CGFloat, yDistance: CGFloat, xVelocity: CGFloat, yVelocity: CGFloat, methodCallNumber: Int) {
        
        buttonDelegate?.buttonWasUntouched(self, triggered: false)
        pressed = false
        animatedUpdate(dimDuration) { (Bool) -> () in }
        
    }
    
    
    
}



public protocol JABButtonDelegate {
    
    func buttonWasTouched(_ button: JABButton)
    func buttonWasUntouched(_ button: JABButton, triggered: Bool)
    
}
