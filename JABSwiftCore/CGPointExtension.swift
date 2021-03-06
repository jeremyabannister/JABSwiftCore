//
//  CGPointExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 4/27/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension CGPoint {
  
  public init <T: FloatingPoint> (x: T, y: T) {
    self.init(x: x.asCGFloat, y: y.asCGFloat)
  }
  public var description: String { return "(\(x), \(y)" }
  public var magnitude: CGFloat { return sqrt(pow(self.x, 2) + pow(self.y, 2)) }
  public static func unitVector <Angle: FloatingPoint> (angle: Angle, inDegrees: Bool = false) -> CGPoint {
    let radians = inDegrees ? angle.radians : angle
    return CGPoint(x: cos(radians.asDouble), y: sin(radians.asDouble))
  }
  
  public func distance (to point: CGPoint) -> CGFloat {
    let difference = CGPoint(x: x - point.x, y: y - point.y)
    return CGFloat(sqrt(Double((difference.x * difference.x) + (difference.y * difference.y))))
  }
  
  public func slope (to point: CGPoint) -> CGFloat? {
    let rise = -(point.y - y)
    let run = point.x - x
    if run == 0 { if rise == 0 { return 0 } else { return nil } }
    return rise/run
  }
  
  public func angle (to point: CGPoint) -> CGFloat {
    if self == point { return 0 }
    guard let slope = slope(to: point) else {
      if point.y < self.y { return (-.pi/2).reducedRadians } else { return (.pi/2).reducedRadians }
    }
    if point.x > self.x { return -atan(slope).reducedRadians } else { return (-atan(slope) + .pi).reducedRadians }
  }
  
  public func rotated (by angularDisplacement: CGFloat, around anchorPoint: CGPoint = .zero) -> CGPoint {
    let distanceFromAnchor = anchorPoint.distance(to: self)
    let currentAngleRelativeToAnchor = anchorPoint.angle(to: self)
    let newAngleRelativeToAnchor = currentAngleRelativeToAnchor + angularDisplacement
    return anchorPoint + (distanceFromAnchor * CGPoint.unitVector(angle: newAngleRelativeToAnchor, inDegrees: false))
  }
  
  public func unitVector (towards point: CGPoint) -> CGPoint {
    return CGPoint.unitVector(angle: self.angle(to: point), inDegrees: false)
  }
  
  public func dotted (with other: CGPoint) -> CGFloat {
    return (self.x * other.x) + (self.y * other.y)
  }
  
  
  // ---------------
  // MARK: Print
  // ---------------
  public func print () { Swift.print(self.description) }
}



// Basic
public func + (left: CGPoint, right: CGPoint) -> CGPoint { return CGPoint(x: left.x + right.x, y: left.y + right.y) }
public func - (left: CGPoint, right: CGPoint) -> CGPoint { return CGPoint(x: left.x - right.x, y: left.y - right.y) }
public func * (left: CGPoint, right: CGFloat) -> CGPoint { return CGPoint(x: left.x * right, y: left.y * right) }
public func * (left: CGFloat, right: CGPoint) -> CGPoint { return right * left }
public func * (left: (CGPoint, CGPoint), right: CGFloat) -> (CGPoint, CGPoint) { return (left.0 * right, left.1 * right) }
public func / (left: CGPoint, right: CGFloat) -> CGPoint { return CGPoint(x: left.x/right, y: left.y/right) }


// Dot Product
infix operator •
public func • (left: CGPoint, right: CGPoint) -> CGFloat { return (left.x * right.x) + (left.y * right.y) }

// Norm Operator
postfix operator •|
public postfix func •| (point: CGPoint) -> CGFloat { return sqrt(CGFloat(point•point)) }

// Unit Vector
postfix operator •^
public postfix func •^ (point: CGPoint) -> CGPoint? { if point•| != 0 { return point/(point•|) } else { return nil } }

// Cross Product // Only return the z value of the cross product since x and y values are 0
infix operator ***
public func *** (left: CGPoint, right: CGPoint) -> CGFloat { return (left.x * right.y) - (left.y * right.x) }

// Angle Between Vectors
infix operator •<
public func •< (left: CGPoint, right: CGPoint) -> CGFloat { return acos((left • right)/((left•|) * (right•|))) }

// Vector Rotation
infix operator &<
infix operator &>
public func &< (left: CGPoint, right: CGFloat) -> CGPoint { return CGPoint(x: (left.x * cos(right)) + (left.y * sin(right)), y: (left.x * sin(-right)) + (left.y * cos(right))) }
public func &> (left: CGPoint, right: CGFloat) -> CGPoint { return left &< -right  }


