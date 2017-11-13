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
    weak open var delegate: JABImageBankDelegate?
    
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
    fileprivate let newMediaButton = JABTextButton()
    fileprivate let paneledScrollView = JABPaneledScrollView()
    
    
    // MARK: Parameters
    
    
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
        let view = newMediaButton
        
        view.buttonDelegate = self
        view.dimsWhenPressed = true
        
        view.text = "+"
        view.textAlignment = .center
        view.textColor = .black
        view.font = UIFont(name: "AvenirNext-DemiBold", size: 24)
        
        view.backdropColor = UIColor(white: 0.8, alpha: 1)
        view.shadowRadius = 3
        view.shadowOpacity = 0.3
        view.shadowOffset = CGSize(width: 0, height: 2)
        
        view.updateAllUI()
        
    }
    
    fileprivate func positionNewMediaButton () {
        let view = newMediaButton
        // Not using normal positioning format because we do not want to set the origin to anything
        view.width = width
        view.height = 60
        
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
        
        paneledScrollView.frame = bounds
        
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
    
    open func buttonWasUntouched(_ button: JABButton, wasTriggered: Bool) {
        if wasTriggered {
            switch button {
            case newMediaButton:
                newMediaButtonPressed()
            default:
                break
            }
        }
    }
    
}


public protocol JABImageBankDelegate: class {
    func imageBankWantsToDeleteImage (_ imageBank: JABImageBank, image: UIImage, atIndex index: Int)
    
    func imageBankDidSelectCamera (_ imageBank: JABImageBank)
    func imageBankDidSelectPhotos (_ imageBank: JABImageBank)
}
