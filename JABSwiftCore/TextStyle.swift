//
//  TextStyle.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/29/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

// MARK: - Initial Declaration
public struct TextStyle {
  public var font: Font
  public var textColor: Color = .black
  public var textAlignment: TextAlignment
  public var characterSpacing: Double
  
  public init (font: Font, textColor: Color, textAlignment: TextAlignment = .center, characterSpacing: Double = 1) {
    self.font = font
    self.textColor = textColor
    self.textAlignment = textAlignment
    self.characterSpacing = characterSpacing
  }
  public func colored (with newTextColor: Color) -> TextStyle { return TextStyle(font: self.font, textColor: newTextColor, textAlignment: self.textAlignment, characterSpacing: self.characterSpacing) }
  public func withFont (_ newFont: Font) -> TextStyle { return TextStyle(font: newFont, textColor: self.textColor, textAlignment: self.textAlignment, characterSpacing: self.characterSpacing) }
  public func withTextAlignment (_ newTextAlignment: TextAlignment) -> TextStyle { return TextStyle(font: self.font, textColor: self.textColor, textAlignment: newTextAlignment, characterSpacing: self.characterSpacing) }
  public func withCharacterSpacing (_ newCharacterSpacing: Double) -> TextStyle { return TextStyle(font: self.font, textColor: self.textColor, textAlignment: self.textAlignment, characterSpacing: newCharacterSpacing) }
  
  
  public func dimmed (to fraction: Double) -> TextStyle { return self.colored(with: self.textColor.dimmed(to: fraction)) }
}

public extension TextStyle {
  public static let `default`: TextStyle = TextStyle(font: .default, textColor: .black)
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
    textAlignment = NSTextAlignment(textStyle.textAlignment)
    characterSpacing = CGFloat(textStyle.characterSpacing)
  }
  
  
  public func colored (with newTextColor: UIColor) -> TextStyleForUILabel { return TextStyleForUILabel(textColor: newTextColor, font: self.font, textAlignment: self.textAlignment, characterSpacing: self.characterSpacing) }
  public func withFont (_ newFont: UIFont?) -> TextStyleForUILabel { return TextStyleForUILabel(textColor: self.textColor, font: newFont, textAlignment: self.textAlignment, characterSpacing: self.characterSpacing) }
  public func withTextAlignment (_ newTextAlignment: NSTextAlignment) -> TextStyleForUILabel { return TextStyleForUILabel(textColor: self.textColor, font: self.font, textAlignment: newTextAlignment, characterSpacing: self.characterSpacing) }
  public func withCharacterSpacing (_ newCharacterSpacing: CGFloat?) -> TextStyleForUILabel { return TextStyleForUILabel(textColor: self.textColor, font: self.font, textAlignment: self.textAlignment, characterSpacing: newCharacterSpacing) }
  
  
  public func dim (_ fraction: CGFloat) -> TextStyleForUILabel { return self.colored(with: self.textColor.dim(fraction)) }
  
  
  public var asTextStyle: TextStyle { return TextStyle(font: font?.asFont ?? .default, textColor: textColor.asColor, textAlignment: textAlignment.asTextAlignment, characterSpacing: characterSpacing?.asDouble ?? 1) }
}
