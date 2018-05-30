//
//  TextStyle.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/29/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

// MARK: - Initial Declaration
public struct TextStyle {
  public var textColor: Color = .black
  public var font: Font?
  public var textAlignment: NSTextAlignment
  public var characterSpacing: Double?
  public init (textColor: Color?, font: Font?, textAlignment: NSTextAlignment, characterSpacing: Double? = nil) {
    if let textColor = textColor { self.textColor = textColor }
    self.font = font
    self.textAlignment = textAlignment
    if let characterSpacing = characterSpacing { self.characterSpacing = characterSpacing }
  }
  public func colored (with newTextColor: Color) -> TextStyle { return TextStyle(textColor: newTextColor, font: self.font, textAlignment: self.textAlignment, characterSpacing: self.characterSpacing) }
  public func withFont (_ newFont: Font?) -> TextStyle { return TextStyle(textColor: self.textColor, font: newFont, textAlignment: self.textAlignment, characterSpacing: self.characterSpacing) }
  public func withTextAlignment (_ newTextAlignment: NSTextAlignment) -> TextStyle { return TextStyle(textColor: self.textColor, font: self.font, textAlignment: newTextAlignment, characterSpacing: self.characterSpacing) }
  public func withCharacterSpacing (_ newCharacterSpacing: Double?) -> TextStyle { return TextStyle(textColor: self.textColor, font: self.font, textAlignment: self.textAlignment, characterSpacing: newCharacterSpacing) }
  
  
  public func dimmed (to fraction: Double) -> TextStyle { return self.colored(with: self.textColor.dimmed(to: fraction)) }
}


public struct TextStyleForUILabel {
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
  public init? (_ textStyle: TextStyle?) {
    guard let textStyle = textStyle else { return nil }
    textColor = UIColor(textStyle.textColor)
    font = UIFont(textStyle.font)
    textAlignment = textStyle.textAlignment
    characterSpacing = CGFloat(textStyle.characterSpacing)
  }
  
  
  public func colored (with newTextColor: UIColor) -> TextStyleForUILabel { return TextStyleForUILabel(textColor: newTextColor, font: self.font, textAlignment: self.textAlignment, characterSpacing: self.characterSpacing) }
  public func withFont (_ newFont: UIFont?) -> TextStyleForUILabel { return TextStyleForUILabel(textColor: self.textColor, font: newFont, textAlignment: self.textAlignment, characterSpacing: self.characterSpacing) }
  public func withTextAlignment (_ newTextAlignment: NSTextAlignment) -> TextStyleForUILabel { return TextStyleForUILabel(textColor: self.textColor, font: self.font, textAlignment: newTextAlignment, characterSpacing: self.characterSpacing) }
  public func withCharacterSpacing (_ newCharacterSpacing: CGFloat?) -> TextStyleForUILabel { return TextStyleForUILabel(textColor: self.textColor, font: self.font, textAlignment: self.textAlignment, characterSpacing: newCharacterSpacing) }
  
  
  public func dim (_ fraction: CGFloat) -> TextStyleForUILabel { return self.colored(with: self.textColor.dim(fraction)) }
}
