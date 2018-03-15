//
//  CLLocationExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 1/26/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
  public func midPoint (to other: CLLocation) -> CLLocation { return CLLocation(latitude: self.coordinate.midPoint(to: other.coordinate).latitude, longitude: self.coordinate.midPoint(to: other.coordinate).longitude) }
  
  // ---------------
  // MARK: Print
  // ---------------
  public func print () { Swift.print(self) }
}
