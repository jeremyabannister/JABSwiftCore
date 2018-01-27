//
//  CLLocationCoordinate2DExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 1/26/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
  public func midPoint (to other: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: (latitude + other.latitude)/2, longitude: (longitude + other.longitude)/2)
  }
  
  public func heading (toward other: CLLocationCoordinate2D) -> CLLocationDirection {
    let dLongitude = other.longitude.radians - self.longitude.radians
    let y = sin(dLongitude) * cos(other.latitude.radians)
    let x = cos(self.latitude.radians) * sin(other.latitude.radians) - sin(self.latitude.radians) * cos(other.latitude.radians) * cos(dLongitude)
    return atan2(y, x).degrees
  }
}
