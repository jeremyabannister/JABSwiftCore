//
//  SRTCamera.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 10/28/15.
//  Copyright © 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public class SRTCamera: JABView {
    
    // MARK:
    // MARK: Properties
    // MARK:
    
    // MARK: Delegate
    public var delegate: protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>? {
        get {
            return imagePicker.delegate
        }
        set {
            imagePicker.delegate = newValue
        }
    }
    
    
    // MARK: State
    
    // MARK: UI
    private let imagePicker = UIImagePickerController()
    
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
        
        addImagePicker()
        
    }
    
    override public func updateAllUI() {
        
        updateParameters()
        
        
        configureImagePicker()
        positionImagePicker()
        
        
    }
    
    
    // MARK: Adding
    private func addImagePicker () {
        addSubview(imagePicker.view)
    }
    
    
    
    // MARK: Image Picker
    private func configureImagePicker () {
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        
    }
    
    private func positionImagePicker () {
        
        imagePicker.view.frame = relativeFrame
        
    }
    
    
    // MARK:
    // MARK: Actions
    // MARK:
    
    
    
    // MARK:
    // MARK: Delegate Methods
    // MARK:
    
    
}
