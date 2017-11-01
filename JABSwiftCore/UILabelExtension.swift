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

public extension UILabel {
    public var textStyle: TextStyle? {
        get {
            var storedTextStyle = objc_getAssociatedObject(self, &UILabelTextStyleAssociationKey) as? TextStyle
            storedTextStyle?.textColor = self.textColor
            storedTextStyle?.font = self.font
            storedTextStyle?.textAlignment = self.textAlignment
            return storedTextStyle
        }
        set {
            self.textColor = newValue?.textColor
            self.font = newValue?.font
            self.textAlignment = newValue?.textAlignment ?? .center
            objc_setAssociatedObject(self, &UILabelTextStyleAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}




public struct TextStyle {
    public var textColor: UIColor = .black
    public var font: UIFont?
    public var textAlignment: NSTextAlignment
    public init (textColor: UIColor?, font: UIFont?, textAlignment: NSTextAlignment) {
        if let textColor = textColor { self.textColor = textColor }
        self.font = font
        self.textAlignment = textAlignment
    }
    public func colored (with newTextColor: UIColor) -> TextStyle { return TextStyle(textColor: newTextColor, font: self.font, textAlignment: self.textAlignment) }
    public func dim (_ fraction: CGFloat) -> TextStyle { return self.colored(with: self.textColor.dim(fraction)) }
    public func withFont (_ newFont: UIFont?) -> TextStyle { return TextStyle(textColor: self.textColor, font: newFont, textAlignment: self.textAlignment) }
    public func withTextAlignment (_ newTextAlignment: NSTextAlignment) -> TextStyle { return TextStyle(textColor: self.textColor, font: self.font, textAlignment: newTextAlignment) }
}
