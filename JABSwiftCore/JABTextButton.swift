//
//  JABTextButton.swift
//  Findr
//
//  Created by Jeremy Bannister on 8/12/17.
//  Copyright © 2017 Findr LLC. All rights reserved.
//

import UIKit

open class JABTextButton: JABButton {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    
    // MARK: State
    open var text = ""
    open var textAlignment = NSTextAlignment.center
    open var font = UIFont(name: "HelveticaNeue-Medium", size: 12)
    open var numberOfLines: Int?
    
    fileprivate var undimmedTextColor: UIColor?
    open var textColor: UIColor? {
        get { return label.textColor }
        set { undimmedTextColor = newValue }
    }
    
    open var contentInsetForText: CGFloat?
    open var textDimsWhenPressed = false
    open var textDimFraction: CGFloat?
    
    // MARK: UI
    fileprivate let label = UILabel()
    
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
        
        addLabel()
        
    }
    
    override open func updateAllUI() {
        
        super.updateAllUI()
        updateParameters()
        
        
        configureLabel()
        positionLabel()
        
    }
    
    
    // MARK: Adding
    fileprivate func addLabel () {
        addSubview(label)
    }
    
    
    
    // MARK: Text Label
    fileprivate func configureLabel () {
        let view = label
        
        view.text = text
        view.textAlignment = textAlignment
        view.font = font
        if numberOfLines != nil { view.numberOfLines = numberOfLines! }
        
        if textDimsWhenPressed {
            view.textColor = undimmedTextColor?.dim(1 - (visualPressedExtent * (1 - (textDimFraction ?? dimFraction))))
        }
        else { view.textColor = undimmedTextColor }
        
    }
    
    fileprivate func positionLabel () {
        let view = label
        var newFrame = CGRect.zero
        guard let text = view.text else { return }
        let size = view.font.sizeOfString(text, constrainedToWidth: width - 2*(contentInsetForText ?? 0))
        
        newFrame.size.width = size.width
        newFrame.size.height = size.height
        
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
