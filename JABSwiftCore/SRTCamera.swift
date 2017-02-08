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
    
    // MARK: UI
    fileprivate let imagePicker = UIImagePickerController()
    
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
        imagePicker.mediaTypes = ["public.image", "public.movie"]
        
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
