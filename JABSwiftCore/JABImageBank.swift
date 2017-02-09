//
//  JABImageBank.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 11/3/15.
//  Copyright © 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

open class JABImageBank: JABView, JABPaneledScrollViewDelegate, JABButtonDelegate {

    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    open var delegate: JABImageBankDelegate?
    
    // MARK: State
    open var numberOfColumns = 1
    open var images = [UIImage]() {
        didSet {
            paneledScrollView.deleteAllPanels()
            
            var panels = [JABImagePanel]()
            for image in images {
                panels.append(JABImagePanel(image: image))
            }
            
            paneledScrollView.loadWithPanels(panels)
        }
    }
    
    // MARK: UI
    fileprivate let newMediaButton = JABButton()
    fileprivate let paneledScrollView = JABPaneledScrollView()
    
    
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
    
    override open func globalVariablesWereInitialized() {
        
        updateParameters()
        
    }
    
    
    // MARK: Parameters
    override open func updateParameters() {
        
        
        if iPad {
            
        }
        
    }
    
    
    
    
    // MARK:
    // MARK: UI
    // MARK:
    
    
    // MARK: All
    override open func addAllUI() {
        
        addNewMediaButton()
        addPaneledScrollView()
        
    }
    
    override open func updateAllUI() {
        
        updateParameters()
        
        
        configureNewMediaButton()
        positionNewMediaButton()
        
        positionPaneledScrollView()
        configurePaneledScrollView()
        
    }
    
    
    // MARK: Adding
    fileprivate func addPaneledScrollView () {
        addSubview(paneledScrollView)
    }
    
    fileprivate func addNewMediaButton () {
        // Do nothing because the paneled scroll view will add the top view as a subview when it is assigned
    }
    
    
    
    
    // MARK: New Media Button
    fileprivate func configureNewMediaButton () {
        
        newMediaButton.type = .text
        newMediaButton.buttonDelegate = self
        
        newMediaButton.text = "+"
        newMediaButton.textAlignment = .center
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
    
    fileprivate func positionNewMediaButton () {
        
        // Not using normal positioning format because we do not want to set the origin to anything
        newMediaButton.width = width
        newMediaButton.height = 60
        
    }
    
    
    // MARK: Paneled Scroll View
    fileprivate func configurePaneledScrollView () {
        
        paneledScrollView.delegate = self
        
        paneledScrollView.numberOfColumns = numberOfColumns
        paneledScrollView.betweenBufferForRows = 5
        paneledScrollView.topBuffer = 10
        paneledScrollView.topView = newMediaButton
        
    }
    
    fileprivate func positionPaneledScrollView () {
        
        paneledScrollView.frame = relativeFrame
        
    }
    
    
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    // MARK: Panel
    fileprivate func panelWasLongPressed (_ panel: JABImagePanel, panelIndex: Int) {
        
        let alertController = UIAlertController(title: nil, message: "Choose what to do with the selected photo.", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
        
        let copyAction = UIAlertAction(title: "Copy", style: .default) { (action) in
            if let image = panel.image {
                UIPasteboard.general.image = image
            }
        }
        alertController.addAction(copyAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            if self.images.count > panelIndex {
                self.delegate?.imageBankWantsToDeleteImage(self, image: self.images[panelIndex], atIndex: panelIndex)
            }
        }
        alertController.addAction(deleteAction)
        
        rootViewController.present(alertController, animated: true) {
            
        }
    }
    
    
    // MARK: Buttons
    fileprivate func newMediaButtonPressed () {
        
        let alertController = UIAlertController(title: nil, message: "Either take a new picture or choose an existing one.", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.delegate?.imageBankDidSelectCamera(self)
        }
        alertController.addAction(cameraAction)
        
        let photosAction = UIAlertAction(title: "Photos", style: .default) { (action) in
            self.delegate?.imageBankDidSelectPhotos(self)
        }
        alertController.addAction(photosAction)
        
        rootViewController.present(alertController, animated: true) {
            
        }
        
    }
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    // MARK: Paneled Scroll View
    open func paneledScrollViewPanelWasTapped(_ paneledScrollView: JABPaneledScrollView, panel: JABPanel, panelIndex: Int) {
        
    }
    
    open func paneledScrollViewPanelWasLongPressed(_ paneledScrollView: JABPaneledScrollView, panel: JABPanel, panelIndex: Int) {
        
        if let imagePanel = panel as? JABImagePanel {
            panelWasLongPressed(imagePanel, panelIndex: panelIndex)
        }
    }
    
    
    // MARK: Button
    open func buttonWasTouched(_ button: JABButton) {
        
    }
    
    open func buttonWasUntouched(_ button: JABButton, triggered: Bool) {
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
    func imageBankWantsToDeleteImage (_ imageBank: JABImageBank, image: UIImage, atIndex index: Int)
    
    func imageBankDidSelectCamera (_ imageBank: JABImageBank)
    func imageBankDidSelectPhotos (_ imageBank: JABImageBank)
}