//
//  SRTCamera.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 10/28/15.
//  Copyright © 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

open class SRTCamera: JABView {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    open var delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        get {
            return imagePicker.delegate!
        }
        set {
            imagePicker.delegate = newValue
        }
    }
    
    
    // MARK: State
    public var cameraDevice = UIImagePickerControllerCameraDevice.rear
    public var mediaTypes: [String]?
    
    // MARK: UI
    fileprivate let imagePicker = UIImagePickerController()
    
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
        
        addImagePicker()
        
    }
    
    override open func updateAllUI() {
        
        updateParameters()
        
        
        configureImagePicker()
        positionImagePicker()
        
        
    }
    
    
    // MARK: Adding
    fileprivate func addImagePicker () {
        addSubview(imagePicker.view)
    }
    
    
    
    // MARK: Image Picker
    fileprivate func configureImagePicker () {
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.cameraDevice = cameraDevice
        
        if mediaTypes != nil {
            imagePicker.mediaTypes = mediaTypes!
        } else {
            imagePicker.mediaTypes = ["public.image", "public.movie"]
        }
        
    }
    
    fileprivate func positionImagePicker () {
        
        imagePicker.view.frame = relativeFrame
        
    }
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    
}
