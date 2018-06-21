//
//  PassthroughView.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/20/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

public class PassthroughView: View {
  // Outlet
  public let passthroughOutlet: PassthroughVisualOutlet?
  
  // Init
  public init (passthroughOutlet: PassthroughVisualOutlet?) {
    self.passthroughOutlet = passthroughOutlet
    super.init(outlet: self.passthroughOutlet)
  }
  
  public override init () {
    self.passthroughOutlet = PassthroughVisualOutletFactory.createNewPassthroughOutlet()
    super.init(outlet: self.passthroughOutlet)
  }
}
