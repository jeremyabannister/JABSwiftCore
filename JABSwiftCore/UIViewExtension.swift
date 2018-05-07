//
//  UIViewExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/19/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
  public var uiImage: UIImage? {
    if #available(iOS 10, *) {
      let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
      return renderer.image { ctx in self.drawHierarchy(in: self.bounds, afterScreenUpdates: true) }
    }
    return nil
  }
}

public extension UIView {
  public func addSubviews (_ subviews: [UIView]) {
    subviews.forEach({ addSubview($0) })
  }
}
