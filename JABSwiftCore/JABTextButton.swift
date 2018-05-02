//
//  JABTextButton.swift
//  Findr
//
//  Created by Jeremy Bannister on 8/12/17.
//  Copyright © 2017 Findr LLC. All rights reserved.
//

import UIKit

open class JABTextButton: JABButton {
  
  // MARK:
  // MARK: Properties
  // MARK:
  
  // MARK: Delegate
  
  // MARK: State
  open var text: String
  open var textColor: UIColor { get { return undimmedTextStyle?.textColor ?? .black } set { textStyle = textStyle?.colored(with: newValue) } }
  open var textAlignment: NSTextAlignment { get { return undimmedTextStyle?.textAlignment ?? .center } set { textStyle = textStyle?.withTextAlignment(newValue) } }
  open var font: UIFont? { get { return undimmedTextStyle?.font } set { textStyle = textStyle?.withFont(newValue) } }
  open var numberOfLines: Int?
  override open var topOfContent: CGFloat { return self.top + label.top }
  
  fileprivate var undimmedTextStyle: TextStyle?
  open var textStyle: TextStyle? {
    get { return label.textStyle }
    set { undimmedTextStyle = newValue }
  }
  
  open var contentInsetForText: CGFloat?
  open var textDimsWhenPressed = false
  open var textDimFraction: CGFloat?
  
  // Interface Elements
  override open var interfaceElements: [InterfaceElement?] { return super.interfaceElements + [label] }
  
  // MARK: UI
  private let label = UILabel()
  
  // MARK: Parameters
  
  
  
  
  
  // **********************************************************************************************************************
  
  
  // MARK:
  // MARK: Methods
  // MARK:
  
  // MARK:
  // MARK: Init
  // MARK:
  
  public init (text: String = "") {
    self.text = text
    super.init()
    addUI()
  }
  public required init? (coder aDecoder: NSCoder) { return nil }
  
  
  
  
  // MARK:
  // MARK: UI
  // MARK:
  
  
  // MARK: All
  override open func addUI() {
    super.addUI()
    
    addSubview(label)
  }
  
  override open func updateUI() {
    
    super.updateUI()
    
    configureLabel()
    positionLabel()
    
  }
  
  
  
  // MARK: Text Label
  fileprivate func configureLabel () {
    let view = label
    
    view.text = text
    if numberOfLines != nil { view.numberOfLines = numberOfLines! }
    
    if textDimsWhenPressed {
      view.textStyle = undimmedTextStyle?.dim(1 - (visualPressedExtent * (1 - (textDimFraction ?? dimFraction))))
    }
    else { view.textStyle = undimmedTextStyle }
    
  }
  
  fileprivate func positionLabel () {
    let view = label
    var newSite = CGRect.zero
    guard let size = view.size(constrainedToWidth: width - 2*(contentInsetForText ?? 0)) else { return }
    
    newSite.size.width = size.width
    newSite.size.height = size.height
    
    newSite.origin.x = (width - newSite.size.width)/2
    newSite.origin.y = (height - newSite.size.height)/2
    
    view.site = newSite
  }
  
  
  // MARK:
  // MARK: Actions
  // MARK:
  
  
  // MARK:
  // MARK: Delegate Methods
  // MARK:
  
}

