//
//  JABImageBank.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 11/3/15.
//  Copyright © 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public class JABImageBank: JABView, JABButtonDelegate {

    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    public var delegate: JABImageBankDelegate?
    
    // MARK: State
    public var numberOfColumns = 1
    
    // MARK: UI
    private let newMediaButton = JABButton()
    private let paneledScrollView = JABPaneledScrollView()
    
    
    // MARK: Parameters
    // Most parameters are expressed as a fraction of the width of the view. This is done so that if the view is animated to a different frame the subviews will adjust accordingly, which would not happen if all spacing was defined statically
    
    
    
    
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
        print("Should not be initializing from coder \(self)")
    }
    
    override public func globalVariablesWereInitialized() {
        
        updateParameters()
        
    }
    
    
    // MARK: Parameters
    override public func updateParameters() {
        
        
        if iPad {
            
        }
        
    }
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    
    // MARK: All
    override public func addAllUI() {
        
        addNewMediaButton()
        addPaneledScrollView()
        
    }
    
    override public func updateAllUI() {
        
        updateParameters()
        
        
        configureNewMediaButton()
        positionNewMediaButton()
        
        positionPaneledScrollView()
        configurePaneledScrollView()
        
    }
    
    
    // MARK: Adding
    private func addPaneledScrollView () {
        addSubview(paneledScrollView)
    }
    
    private func addNewMediaButton () {
        // Do nothing because the paneled scroll view will add the top view as a subview when it is assigned
    }
    
    
    
    
    // MARK: New Media Button
    private func configureNewMediaButton () {
        
        newMediaButton.type = .Text
        newMediaButton.buttonDelegate = self
        
        newMediaButton.text = "+"
        newMediaButton.textAlignment = .Center
        newMediaButton.textColor = blackColor
        newMediaButton.font = UIFont(name: "AvenirNext-DemiBold", size: 24)
        
        newMediaButton.dimsWhenPressed = true
        newMediaButton.textButtonDimsBackground = true
        
        newMediaButton.backgroundColor = UIColor(white: 0.8, alpha: 1)
        newMediaButton.shadowRadius = 3
        newMediaButton.shadowOpacity = 0.3
        newMediaButton.shadowOffset = CGSize(width: 0, height: 2)
        
        newMediaButton.updateAllUI()
        
    }
    
    private func positionNewMediaButton () {
        
        // Not using normal positioning format because we do not want to set the origin to anything
        newMediaButton.width = width
        newMediaButton.height = 60
        
    }
    
    
    // MARK: Paneled Scroll View
    private func configurePaneledScrollView () {
        
        paneledScrollView.numberOfColumns = numberOfColumns
        paneledScrollView.betweenBufferForRows = 5
        paneledScrollView.topBuffer = 10
        paneledScrollView.topView = newMediaButton
        
    }
    
    private func positionPaneledScrollView () {
        
        paneledScrollView.frame = relativeFrame
        
    }
    
    
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    // MARK: Buttons
    private func newMediaButtonPressed () {
        
        let alertController = UIAlertController(title: nil, message: "Either take a new picture or choose an existing one.", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
            self.delegate?.imageBankDidSelectCamera(self)
        }
        alertController.addAction(cameraAction)
        
        let photosAction = UIAlertAction(title: "Photos", style: .Default) { (action) in
            self.delegate?.imageBankDidSelectPhotos(self)
        }
        alertController.addAction(photosAction)
        
        rootViewController.presentViewController(alertController, animated: true) {
            
        }
        
    }
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Button
    public func buttonWasTouched(button: JABButton) {
        
    }
    
    public func buttonWasUntouched(button: JABButton, triggered: Bool) {
        if triggered {
            switch button {
            case newMediaButton:
                newMediaButtonPressed()
            default:
                break
            }
        }
    }
    
}


public protocol JABImageBankDelegate {
    func imageBankDidSelectCamera (imageBank: JABImageBank)
    func imageBankDidSelectPhotos (imageBank: JABImageBank)
}