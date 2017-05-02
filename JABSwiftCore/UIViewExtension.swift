//
//  UIViewExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/19/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    open var x: CGFloat {
        get { return frame.origin.x }
        set { frame.origin.x = newValue } }
    
    open var y: CGFloat {
        get { return frame.origin.y }
        set { frame.origin.y = newValue } }
    
    open var width: CGFloat {
        get { return frame.size.width }
        set { frame.size.width = newValue } }
    
    open var height: CGFloat {
        get { return frame.size.height }
        set { frame.size.height = newValue } }
    
    
    open var left: CGFloat { get { return frame.origin.x } }
    open var right: CGFloat { get { return frame.origin.x + frame.size.width } }
    open var top: CGFloat { get { return frame.origin.y } }
    open var bottom: CGFloat { get { return frame.origin.y + frame.size.height } }
    

    
    // Layer
    open var opacity: Float {
        get { return layer.opacity }
        set { layer.opacity = newValue } }
    
    open var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue } }
    
    open var masksToBounds: Bool {
        get { return layer.masksToBounds }
        set { layer.masksToBounds = newValue } }
    
    open var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue } }
    
    open var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue } }
    
    open var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue } }
    
    open var shadowColor: UIColor? {
        get { return UIColor(cgColor: layer.shadowColor ?? blackColor.cgColor) }
        set { layer.shadowColor = newValue?.cgColor } }
    
    open var shadowPath: CGPath? {
        get { return layer.shadowPath }
        set { layer.shadowPath = newValue } }
    
    
    
    open func printFrame(_ tag: String? = nil) {
        if tag != nil {
            print("\(String(describing: tag)) : (x:\(frame.origin.x), y:\(frame.origin.y), width:\(frame.size.width), height:\(frame.size.height)")
        } else {
            print("(x:\(frame.origin.x), y:\(frame.origin.y), width:\(frame.size.width), height:\(frame.size.height)")
        }
    }
    
    
    open func red () { backgroundColor = UIColor.red }
    open func blue () { backgroundColor = UIColor.blue }
    open func green () { backgroundColor = UIColor.green }
    open func yellow () { backgroundColor = UIColor.yellow }
    open func purple () { backgroundColor = UIColor.purple }
    open func cyan () { backgroundColor = UIColor.cyan }
    open func white () { backgroundColor = UIColor.white }
    open func black () { backgroundColor = UIColor.black }
    open func lightGray () { backgroundColor = UIColor.lightGray }
    open func darkGray () { backgroundColor = UIColor.darkGray }
    
    
    
    // MARK: Subview Manipulation
    open func changeAllTextOfSubviewsToColor(_ color: UIColor) {
        for subview in subviews {
            if let label = subview as? UILabel {
                label.textColor = color
            } else {
                if subview.subviews.count != 0 {
                    subview.changeAllTextOfSubviewsToColor(color)
                }
            }
        }
    }
    
    
}
