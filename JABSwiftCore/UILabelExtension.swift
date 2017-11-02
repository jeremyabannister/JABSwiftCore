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
    public var textStyle: TextStyle? {
        get {
            var storedTextStyle = objc_getAssociatedObject(self, &UILabelTextStyleAssociationKey) as? TextStyle
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




public struct TextStyle {
    public var textColor: UIColor = .black
    public var font: UIFont?
    public var textAlignment: NSTextAlignment
    public var characterSpacing: CGFloat?
    public init (textColor: UIColor?, font: UIFont?, textAlignment: NSTextAlignment, characterSpacing: CGFloat? = nil) {
        if let textColor = textColor { self.textColor = textColor }
        self.font = font
        self.textAlignment = textAlignment
        if let characterSpacing = characterSpacing { self.characterSpacing = characterSpacing }
    }
    public func colored (with newTextColor: UIColor) -> TextStyle { return TextStyle(textColor: newTextColor, font: self.font, textAlignment: self.textAlignment, characterSpacing: self.characterSpacing) }
    public func withFont (_ newFont: UIFont?) -> TextStyle { return TextStyle(textColor: self.textColor, font: newFont, textAlignment: self.textAlignment, characterSpacing: self.characterSpacing) }
    public func withTextAlignment (_ newTextAlignment: NSTextAlignment) -> TextStyle { return TextStyle(textColor: self.textColor, font: self.font, textAlignment: newTextAlignment, characterSpacing: self.characterSpacing) }
    public func withCharacterSpacing (_ newCharacterSpacing: CGFloat?) -> TextStyle { return TextStyle(textColor: self.textColor, font: self.font, textAlignment: self.textAlignment, characterSpacing: newCharacterSpacing) }
    
    
    public func dim (_ fraction: CGFloat) -> TextStyle { return self.colored(with: self.textColor.dim(fraction)) }
}

