//
//  View.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 5/23/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public class View {
  public var frame: Rect = .zero
  public var backgroundColor: Color = .clear
  public var cornerRadius: Double = 0
  public var shadow: Shadow = .none
}

public extension View {
  public var x: Double {
    get { return frame.origin.x }
    set { frame.origin.x = newValue }
  }
  
  public var y: Double {
    get { return frame.origin.y }
    set { frame.origin.y = newValue }
  }
  
  public var width: Double {
    get { return frame.size.width }
    set { frame.size.width = newValue }
  }
  
  public var height: Double {
    get { return frame.size.height }
    set { frame.size.height = newValue }
    
  }
}

