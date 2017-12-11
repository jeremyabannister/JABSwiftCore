//
//  DictionaryExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 11/30/17.
//  Copyright © 2017 Jeremy Bannister. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    // --------------
    // MARK: JSON
    // --------------
    public var jsonString: String? {
        do {
            let contactsAsJSONData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            return String(data: contactsAsJSONData, encoding: String.Encoding.utf8)
        } catch {  }
        return nil
    }
}
