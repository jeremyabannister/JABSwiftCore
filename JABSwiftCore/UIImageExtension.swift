//
//  UIImageExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/21/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
  public func imageTintedWithColor(_ color: UIColor?, fraction: CGFloat = 0) -> UIImage {
    if color == nil { return self }
    // Construct new image the same size as this one.
    var image = UIImage()
    if UIScreen.instancesRespond(to: #selector(NSDecimalNumberBehaviors.scale)) {
      UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    } else {
      UIGraphicsBeginImageContext(size)
    }
    
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    
    // Composite tint color at its own opacity.
    color!.set()
    UIRectFill(rect)
    
    // Mask tint color-swatch to this image's opaque mask.
    // We want behaviour like NSCompositeDestinationIn on Mac OS X.
    draw(in: rect, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
    
    // Finally, composite this image over the tinted mask at desired opacity.
    if fraction > 0.0 {
      draw(in: rect, blendMode: CGBlendMode.sourceAtop, alpha: fraction)
    }
    image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return image
  }
}


extension UIImage {
  public func resized(withPercentage percentage: CGFloat) -> UIImage? {
    let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
    UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
    defer { UIGraphicsEndImageContext() }
    draw(in: CGRect(origin: .zero, size: canvasSize))
    return UIGraphicsGetImageFromCurrentImageContext()
  }
  public func resized(toWidth width: CGFloat) -> UIImage? {
    let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
    UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
    defer { UIGraphicsEndImageContext() }
    draw(in: CGRect(origin: .zero, size: canvasSize))
    return UIGraphicsGetImageFromCurrentImageContext()
  }
}


extension UIImage {
  public func writePNGFileToDisk (_ filename: String) {
    guard let extensionlessFilename = filename.components(separatedBy: ".png").first else { return }
    guard let data = UIImagePNGRepresentation(self) else { return }
    let filename = extensionlessFilename + ".png"
    data.writeToDisk(filename: filename)
  }
  
  public static func readPNGFileFromBundle (_ filename: String) -> UIImage? {
    guard let extensionlessFilename = filename.components(separatedBy: ".png").first else { return nil }
    guard let filePath = Bundle.main.path(forResource: extensionlessFilename, ofType: "png") else { return nil }
    guard let data = NSData(contentsOfFile: filePath) as Data? else { return nil }
    return UIImage(data: data)
  }
  
  public static func readPNGFileFromDisk (_ filename: String) -> UIImage? {
    guard let extensionlessFilename = filename.components(separatedBy: ".png").first else { return nil }
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(extensionlessFilename + ".png")
    guard let data = NSData(contentsOf: fileURL) as Data? else { return nil }
    return UIImage(data: data)
  }
  
  
  public func writeJPGFileToDisk (_ filename: String) {
    guard let extensionlessFilename = filename.components(separatedBy: ".jpg").first else { return }
    guard let data = UIImageJPEGRepresentation(self, 1.0) else { return }
    let filename = extensionlessFilename + ".jpg"
    data.writeToDisk(filename: filename)
  }
  
  public static func readJPGFileFromBundle (_ filename: String) -> UIImage? {
    guard let extensionlessFilename = filename.components(separatedBy: ".jpg").first else { return nil }
    guard let filePath = Bundle.main.path(forResource: extensionlessFilename, ofType: "jpg") else { return nil }
    guard let data = NSData(contentsOfFile: filePath) as Data? else { return nil }
    return UIImage(data: data)
  }
  
  public static func readJPGFileFromDisk (_ filename: String) -> UIImage? {
    guard let extensionlessFilename = filename.components(separatedBy: ".jpg").first else { return nil }
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(extensionlessFilename + ".jpg")
    guard let data = NSData(contentsOf: fileURL) as Data? else { return nil }
    return UIImage(data: data)
  }
}
