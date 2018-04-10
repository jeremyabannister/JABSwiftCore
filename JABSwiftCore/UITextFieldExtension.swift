//
//  UITextFieldExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 11/2/17.
//  Copyright © 2017 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit

fileprivate var UITextFieldTextStyleAssociationKey: UInt8 = 0
fileprivate var UITextFieldCharacterSpacingAssociationKey: UInt8 = 0
fileprivate var UITextFieldParagraphStyleAssociationKey: UInt8 = 0


fileprivate var UITextFieldPlaceholderTextStyleAssociationKey: UInt8 = 0
fileprivate var UITextFieldPlaceholderCharacterSpacingAssociationKey: UInt8 = 0
fileprivate var UITextFieldPlaceholderParagraphStyleAssociationKey: UInt8 = 0

public extension UITextField {
    public var textStyle: TextStyle? {
        get {
            var storedTextStyle = objc_getAssociatedObject(self, &UITextFieldTextStyleAssociationKey) as? TextStyle
            storedTextStyle?.textColor = self.textColor ?? .black
            storedTextStyle?.font = self.font
            storedTextStyle?.textAlignment = self.textAlignment
            storedTextStyle?.characterSpacing = self.characterSpacing
            return storedTextStyle
        }
        set {
            self.textColor = newValue?.textColor
            self.font = newValue?.font
            self.textAlignment = newValue?.textAlignment ?? .center
            if let characterSpacing = newValue?.characterSpacing { self.characterSpacing = characterSpacing }
            objc_setAssociatedObject(self, &UITextFieldTextStyleAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public var placeholderTextStyle: TextStyle? {
        get { return objc_getAssociatedObject(self, &UITextFieldPlaceholderTextStyleAssociationKey) as? TextStyle }
        set {
            self.attributedPlaceholder = self.placeholder?.attributed(with: newValue)
            objc_setAssociatedObject(self, &UITextFieldPlaceholderTextStyleAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    
    
    public var characterSpacing: CGFloat? {
        get { return objc_getAssociatedObject(self, &UITextFieldCharacterSpacingAssociationKey) as? CGFloat }
        set {
            objc_setAssociatedObject(self, &UITextFieldCharacterSpacingAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            updateAttributedString()
        }
    }
    public var paragraphStyle: NSMutableParagraphStyle? {
        get { return objc_getAssociatedObject(self, &UITextFieldParagraphStyleAssociationKey) as? NSMutableParagraphStyle }
        set {
            objc_setAssociatedObject(self, &UITextFieldParagraphStyleAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            updateAttributedString()
        }
    }
    public var lineHeight: CGFloat {
        get { return paragraphStyle?.lineHeightMultiple ?? 0 }
        set {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 1.0
            paragraphStyle.lineHeightMultiple = newValue
            paragraphStyle.alignment = self.textAlignment
            self.paragraphStyle = paragraphStyle
        }
    }
    
    
    
    private func updateAttributedString () {
        var attributes: [String: Any] = [:]
        attributes[NSAttributedStringKey.font.rawValue] = self.font
        if let characterSpacing = self.characterSpacing { attributes[NSAttributedStringKey.kern.rawValue] = characterSpacing }
        if let paragraphStyle = self.paragraphStyle { attributes[NSAttributedStringKey.paragraphStyle.rawValue] = paragraphStyle }
        self.typingAttributes = attributes
    }
}


public extension UITextField {
  var leftInset: CGFloat {
    get { return self.leftView?.width ?? 0 }
    set {
      let leftView = UIView()
      leftView.frame = CGRect(x: 0, y: 0, width: newValue, height: height)
      self.leftView = leftView
      self.leftViewMode = .always
    }
  }
}
