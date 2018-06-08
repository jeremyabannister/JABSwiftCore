//
//  iOSStringSizeCalculator.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/8/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import UIKit

public class iOSStringSizeCalculator: StringSizeCalculator {
  public func size (of string: String, constrainedToWidth width: Double?, usingFont font: Font) -> Size {
    var attributes: [NSAttributedStringKey: Any] = [.font: UIFont(font) as Any]
    attributes[.kern] = font.characterSpacing
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = CGFloat(font.lineHeightMultiple)
    attributes[.paragraphStyle] = paragraphStyle
    
    return (string as NSString).boundingRect(with: CGSize(width: width ?? 0, height: Double.greatestFiniteMagnitude),
                                             options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                             attributes: attributes,
                                             context: nil).size.asSize
  }
}
