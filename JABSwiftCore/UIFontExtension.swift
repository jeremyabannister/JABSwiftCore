//
//  UIFontExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/9/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension UIFont {
    
    public func sizeOfString (_ string: String, constrainedToWidth width: CGFloat, characterSpacing: CGFloat? = nil, paragraphStyle: NSMutableParagraphStyle? = nil) -> CGSize {
        var attributes: [NSAttributedStringKey: Any] = [.font: self]
        if let characterSpacing = characterSpacing { attributes[.kern] = characterSpacing }
        if let paragraphStyle = paragraphStyle { attributes[.paragraphStyle] = paragraphStyle }
        
        return (string as NSString).boundingRect(with: CGSize(width: Double(width), height: Double.greatestFiniteMagnitude),
                                                 options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                 attributes: attributes,
                                                 context: nil).size
    }
    
    public static func == (_ lhs: UIFont, rhs: UIFont) -> Bool {
        return lhs.familyName == rhs.familyName && lhs.fontName == rhs.fontName && lhs.pointSize == rhs.pointSize
    }
}

