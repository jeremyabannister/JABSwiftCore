//
//  Vector.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/8/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

open class Vector {
    
    
    // MARK: Properties
    open var x = CGFloat(0)
    open var y = CGFloat(0)
    open var z = CGFloat(0)
    
    open var length: CGFloat {
        get {
            return sqrt(dottedWith(self))
        }
    }
    
    
    
    // MARK: Init
    public init (x: CGFloat, y: CGFloat, z: CGFloat) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public convenience init () {
        self.init(x: 0, y: 0, z: 0)
    }
    
    
    // MARK: Methods
    
    // Booleans
    open func isZero () -> Bool {
        if x == 0 && y == 0 && z == 0 {
            return true
        }
        
        return false
    }
    
    open func isEqualTo (_ vector: Vector) -> Bool {
        if x == vector.x && y == vector.y && z == vector.z {
            return true
        }
        return false
    }
    
    open func isSameDirectionAs (_ vector: Vector) -> Bool {
        let angle = radiansBetween(vector)
        if angle != nil {
            if angle! == 0 {
                return true
            }
            return false
        }
        
        return false
    }
    
    // Addition
    open func addOn(_ vector: Vector) {
        let result = addedOn(vector)
        
        x = result.x
        y = result.y
        z = result.z
    }
    
    open func addedOn(_ vector: Vector) -> Vector {
        let newX = x + vector.x
        let newY = y + vector.y
        let newZ = z + vector.z
        
        return Vector(x: newX, y: newY, z: newZ)
    }
    
    // Subtraction
    open func subtractOff(_ vector: Vector) {
        let result = subtractedOff(vector)
        
        x = result.x
        y = result.y
        z = result.z
    }
    
    open func subtractedOff(_ vector: Vector) -> Vector {
        let newX = x - vector.x
        let newY = y - vector.y
        let newZ = z - vector.z
        
        return Vector(x: newX, y: newY, z: newZ)
    }
    
    // Scaling
    open func scaleBy(_ scalar: CGFloat) {
        let result = scaledBy(scalar)
        
        x = result.x
        y = result.y
        z = result.z
    }
    
    open func scaledBy(_ scalar: CGFloat) -> Vector {
        
        return Vector(x: x * scalar, y: y * scalar, z: z * scalar)
        
    }
    
    
    // Normalization
    open func normalize () {
        let result = self.normalized()
        
        if let normalizedSelf = result {
            x = normalizedSelf.x
            y = normalizedSelf.y
            z = normalizedSelf.z
        }
    }
    
    open func normalized () -> Vector? {
        if self.isZero() {
            return nil
        }
        
        return self.scaledBy(1/self.length)
    }
    
    
    // Angle
    open func radiansBetween(_ vector: Vector) -> CGFloat? {
        
        if self.isZero() {
            
            return nil
            
        } else if vector.isZero() {
            
            return nil
            
        } else {
            
            return acos(self.dottedWith(vector)/(self.length * vector.length))
            
        }
    }
    
    // MARK: Dot Product
    open func dottedWith(_ vector: Vector) -> CGFloat {
        return ((x * vector.x) + (y * vector.y) + (z * vector.z))
    }
    
    
    // MARK: Cross Product
    open func crossWith(_ vector: Vector) {     // Modifies the receiver
        let result = crossedWith(vector)
        
        x = result.x
        y = result.y
        z = result.z
    }
    
    open func crossedWith(_ vector: Vector) -> Vector {     // Returns a new vector
        let newX = (y * vector.z) - (z * vector.y)
        let newY = (z * vector.x) - (x * vector.z)
        let newZ = (x * vector.y) - (y * vector.x)
        
        return Vector(x: newX, y: newY, z: newZ)
    }
    
    
    
}
