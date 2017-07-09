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
    
    /** A shortcut to the view's `frame.origin.x` */
    open var x: CGFloat {
        get { return frame.origin.x }
        set { frame.origin.x = newValue } }
    /** A shortcut to the view's `frame.origin.y` */
    open var y: CGFloat {
        get { return frame.origin.y }
        set { frame.origin.y = newValue } }
    /** A shortcut to the view's `frame.size.width` */
    open var width: CGFloat {
        get { return frame.size.width }
        set { frame.size.width = newValue } }
    /** A shortcut to the view's `frame.size.height` */
    open var height: CGFloat {
        get { return frame.size.height }
        set { frame.size.height = newValue } }
    
    
    /**
     The x-coordinate of the left side of the view.
     
     - note: `myView.left` will always be equal to `myView.x`, but sometimes it is more descriptive in your code to use the word "left", particularly when used in conjunction with `myView.right`
     */
    open var left: CGFloat { get { return frame.origin.x } }
    /**
     The x-coordinate of the right side of the view.
     
     - note: This is equal to `frame.origin.x + frame.size.width`
     */
    open var right: CGFloat { get { return left + width } }
    /**
     The y-coordinate of the top side of the view.
     
     - note: `myView.top` will always be equal to `myView.y`, but sometimes it is more descriptive in your code to use the word "top", particularly when used in conjunction with `myView.bottom`
     */
    open var top: CGFloat { get { return frame.origin.y } }
    /**
     The y-coordinate of the bottom side of the view.
     
     - note: This is equal to `frame.origin.y + frame.size.height`
     */
    open var bottom: CGFloat { get { return top + height } }
    

    
    // Layer
    /** A shortcut to the `opacity` of the view's layer */
    open var opacity: Float {
        get { return layer.opacity }
        set { layer.opacity = newValue } }
    /** A shortcut to the `cornerRadius` of the view's layer */
    open var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue } }
    /** A shortcut to the `masksToBounds` of the view's layer */
    open var masksToBounds: Bool {
        get { return layer.masksToBounds }
        set { layer.masksToBounds = newValue } }
    /** A shortcut to the `shadowOpacity` of the view's layer */
    open var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue } }
    /** A shortcut to the `shadowRadius` of the view's layer */
    open var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue } }
    /** A shortcut to the `shadowOffset` of the view's layer */
    open var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue } }
    /** A shortcut to the `shadowColor` of the view's layer */
    open var shadowColor: UIColor? {
        get { return UIColor(cgColor: layer.shadowColor ?? blackColor.cgColor) }
        set { layer.shadowColor = newValue?.cgColor } }
    /** A shortcut to the `shadowPath` of the view's layer */
    open var shadowPath: CGPath? {
        get { return layer.shadowPath }
        set { layer.shadowPath = newValue } }
    
    
    /**
     Prints the view's frame to the console in a nicely formatted way.
     
     - note: If you pass a string into the `tag` parameter you can then search the console for that particular string in order to jump to the correct spot.
     
     - parameters:
        - tag: An optional string to be printed along with the frame.
     */
    open func printFrame(_ tag: String? = nil) {
        if tag != nil {
            print("\(String(describing: tag)) : (x:\(frame.origin.x), y:\(frame.origin.y), width:\(frame.size.width), height:\(frame.size.height)")
        } else {
            print("(x:\(frame.origin.x), y:\(frame.origin.y), width:\(frame.size.width), height:\(frame.size.height)")
        }
    }
    
    
    
    
    // MARK: Background Color Shortcut Methods
    /**
     A shortcut method to change the background color of the view.
     - note: This is intended for debugging purposes.
     */
    open func red () { backgroundColor = UIColor.red }
    /**
     A shortcut method to change the background color of the view.
     - note: This is intended for debugging purposes.
     */
    open func blue () { backgroundColor = UIColor.blue }
    /**
     A shortcut method to change the background color of the view.
     - note: This is intended for debugging purposes.
     */
    open func green () { backgroundColor = UIColor.green }
    /**
     A shortcut method to change the background color of the view.
     - note: This is intended for debugging purposes.
     */
    open func yellow () { backgroundColor = UIColor.yellow }
    /**
     A shortcut method to change the background color of the view.
     - note: This is intended for debugging purposes.
     */
    open func purple () { backgroundColor = UIColor.purple }
    /**
     A shortcut method to change the background color of the view.
     - note: This is intended for debugging purposes.
     */
    open func cyan () { backgroundColor = UIColor.cyan }
    /**
     A shortcut method to change the background color of the view.
     - note: This is intended for debugging purposes.
     */
    open func white () { backgroundColor = UIColor.white }
    /**
     A shortcut method to change the background color of the view.
     - note: This is intended for debugging purposes.
     */
    open func black () { backgroundColor = UIColor.black }
    /**
     A shortcut method to change the background color of the view.
     - note: This is intended for debugging purposes.
     */
    open func lightGray () { backgroundColor = UIColor.lightGray }
    /**
     A shortcut method to change the background color of the view.
     - note: This is intended for debugging purposes.
     */
    open func darkGray () { backgroundColor = UIColor.darkGray }
    
    
}
