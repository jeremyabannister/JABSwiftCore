//
//  Vector.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/8/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import UIKit

public class Vector {
    
    
    // MARK: Properties
    public var x = CGFloat(0)
    public var y = CGFloat(0)
    public var z = CGFloat(0)
    
    public var length: CGFloat {
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
    public func isZero () -> Bool {
        if x == 0 && y == 0 && z == 0 {
            return true
        }
        
        return false
    }
    
    public func isEqualTo (vector: Vector) -> Bool {
        if x == vector.x && y == vector.y && z == vector.z {
            return true
        }
        return false
    }
    
    public func isSameDirectionAs (vector: Vector) -> Bool {
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
    public func addOn(vector: Vector) {
        let result = addedOn(vector)
        
        x = result.x
        y = result.y
        z = result.z
    }
    
    public func addedOn(vector: Vector) -> Vector {
        let newX = x + vector.x
        let newY = y + vector.y
        let newZ = z + vector.z
        
        return Vector(x: newX, y: newY, z: newZ)
    }
    
    // Subtraction
    public func subtractOff(vector: Vector) {
        let result = subtractedOff(vector)
        
        x = result.x
        y = result.y
        z = result.z
    }
    
    public func subtractedOff(vector: Vector) -> Vector {
        let newX = x - vector.x
        let newY = y - vector.y
        let newZ = z - vector.z
        
        return Vector(x: newX, y: newY, z: newZ)
    }
    
    // Scaling
    public func scaleBy(scalar: CGFloat) {
        let result = scaledBy(scalar)
        
        x = result.x
        y = result.y
        z = result.z
    }
    
    public func scaledBy(scalar: CGFloat) -> Vector {
        
        return Vector(x: x * scalar, y: y * scalar, z: z * scalar)
        
    }
    
    
    // Normalization
    public func normalize () {
        let result = self.normalized()
        
        if let normalizedSelf = result {
            x = normalizedSelf.x
            y = normalizedSelf.y
            z = normalizedSelf.z
        }
    }
    
    public func normalized () -> Vector? {
        if self.isZero() {
            return nil
        }
        
        return self.scaledBy(1/self.length)
    }
    
    
    // Angle
    public func radiansBetween(vector: Vector) -> CGFloat? {
        
        if self.isZero() {
            
            return nil
            
        } else if vector.isZero() {
            
            return nil
            
        } else {
            
            return acos(self.dottedWith(vector)/(self.length * vector.length))
            
        }
    }
    
    // MARK: Dot Product
    public func dottedWith(vector: Vector) -> CGFloat {
        return ((x * vector.x) + (y * vector.y) + (z * vector.z))
    }
    
    
    // MARK: Cross Product
    public func crossWith(vector: Vector) {     // Modifies the receiver
        let result = crossedWith(vector)
        
        x = result.x
        y = result.y
        z = result.z
    }
    
    public func crossedWith(vector: Vector) -> Vector {     // Returns a new vector
        let newX = (y * vector.z) - (z * vector.y)
        let newY = (z * vector.x) - (x * vector.z)
        let newZ = (x * vector.y) - (y * vector.x)
        
        return Vector(x: newX, y: newY, z: newZ)
    }
    
    
    
}
