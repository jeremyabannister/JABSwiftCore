//
//  DataExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 1/28/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

import Foundation

extension Data {
  public func writeToDisk (filename: String) {
    let fileWrapper = FileWrapper(regularFileWithContents: self)
    fileWrapper.filename = filename
    do {
      let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(filename)
      try fileWrapper.write(to: fileURL, options: .atomic, originalContentsURL: nil)
    } catch { print(error) }
  }
}
