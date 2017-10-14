//
//  CGContextExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 10/13/17.
//  Copyright © 2017 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension CGContext {
    public func addLine (to point: CGPoint, softenedByRadius cornerRadius: CGFloat, endingInDirectionOf nextPoint: CGPoint, clockwise: Bool) {
        let numerator = (point.unitVector(towards: nextPoint).rotated(by: -.pi/2) - point.unitVector(towards: currentPointOfPath).rotated(by: .pi/2)).magnitude
        let denominator = (point.unitVector(towards: currentPointOfPath) - point.unitVector(towards: nextPoint)).magnitude
        let distanceFromPointToPoint1 = cornerRadius * (numerator/denominator)
        let point1 = point + (distanceFromPointToPoint1 * point.unitVector(towards: currentPointOfPath))
        
        addLine(to: point1)
        
        let arcCenter = point1 + (cornerRadius * point.unitVector(towards: currentPointOfPath).rotated(by: .pi/2))
        let startAngle = point.angle(to: currentPointOfPath) - .pi/2
        let endAngle = point.angle(to: nextPoint) + .pi/2
        
        addArc(center: arcCenter, radius: cornerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    }
}
