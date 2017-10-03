//
//  CABasicAnimationExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 10/2/17.
//  Copyright © 2017 Jeremy Bannister. All rights reserved.
//

import Foundation

extension CABasicAnimation {
    public convenience init (keyPath: String?, fromValue: Any?, toValue: Any?) {
        self.init(keyPath: keyPath)
        self.fromValue = fromValue
        self.toValue = toValue
    }
}
