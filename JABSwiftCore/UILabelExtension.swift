//
//  UILabelExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 11/1/17.
//  Copyright © 2017 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit

fileprivate var UILabelTextStyleAssociationKey: UInt8 = 0
fileprivate var UILabelParagraphStyleAssociationKey: UInt8 = 0
fileprivate var UILabelCharacterSpacingAssociationKey: UInt8 = 0

public extension UILabel {
    public var textStyle: TextStyleForUILabel? {
        get {
            var storedTextStyle = objc_getAssociatedObject(self, &UILabelTextStyleAssociationKey) as? TextStyleForUILabel
            storedTextStyle?.textColor = self.textColor
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
            objc_setAssociatedObject(self, &UILabelTextStyleAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public var characterSpacing: CGFloat? {
        get { return objc_getAssociatedObject(self, &UILabelCharacterSpacingAssociationKey) as? CGFloat }
        set {
            objc_setAssociatedObject(self, &UILabelCharacterSpacingAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            updateAttributedString()
        }
    }
    public var paragraphStyle: NSMutableParagraphStyle? {
        get { return objc_getAssociatedObject(self, &UILabelParagraphStyleAssociationKey) as? NSMutableParagraphStyle }
        set {
            objc_setAssociatedObject(self, &UILabelParagraphStyleAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
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
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        attributedString.addAttribute(.font, value: self.font, range: NSMakeRange(0, attributedString.length))
        if let characterSpacing = self.characterSpacing {
            attributedString.addAttribute(.kern, value: characterSpacing, range: NSMakeRange(0, attributedString.length))
        }
        if let paragraphStyle = self.paragraphStyle {
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle as Any, range: NSMakeRange(0, attributedString.length))
        }
        self.attributedText = attributedString
    }
    
    
    
    public func size (constrainedToWidth maximumWidth: CGFloat) -> CGSize? {
        guard let text = self.text else { return nil }
        return self.font.sizeOfString(text, constrainedToWidth: maximumWidth, characterSpacing: self.characterSpacing, paragraphStyle: self.paragraphStyle)
    }
}


