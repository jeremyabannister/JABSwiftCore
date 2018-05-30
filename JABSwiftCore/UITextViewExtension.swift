//
//  UITextViewExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 3/17/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation


fileprivate var UITextViewTextStyleAssociationKey: UInt8 = 0
fileprivate var UITextViewCharacterSpacingAssociationKey: UInt8 = 0
fileprivate var UITextViewParagraphStyleAssociationKey: UInt8 = 0


fileprivate var UITextViewPlaceholderTextStyleAssociationKey: UInt8 = 0
fileprivate var UITextViewPlaceholderCharacterSpacingAssociationKey: UInt8 = 0
fileprivate var UITextViewPlaceholderParagraphStyleAssociationKey: UInt8 = 0

public extension UITextView {
  public var textStyle: TextStyleForUILabel? {
    get {
      var storedTextStyle = objc_getAssociatedObject(self, &UITextViewTextStyleAssociationKey) as? TextStyleForUILabel
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
      objc_setAssociatedObject(self, &UITextViewTextStyleAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }
  
  
  
  
  public var characterSpacing: CGFloat? {
    get { return objc_getAssociatedObject(self, &UITextViewCharacterSpacingAssociationKey) as? CGFloat }
    set {
      objc_setAssociatedObject(self, &UITextViewCharacterSpacingAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
      updateAttributedString()
    }
  }
  public var paragraphStyle: NSMutableParagraphStyle? {
    get { return objc_getAssociatedObject(self, &UITextViewParagraphStyleAssociationKey) as? NSMutableParagraphStyle }
    set {
      objc_setAssociatedObject(self, &UITextViewParagraphStyleAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
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
