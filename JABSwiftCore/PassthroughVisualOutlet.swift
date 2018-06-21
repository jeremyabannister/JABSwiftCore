//
//  PassthroughVisualOutlet.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 6/20/18.
//  Copyright © 2018 Jeremy Bannister. All rights reserved.
//

// A PassthroughVisualOutlet is a view which exhibits the behavior that it does not intercept touch events itself, but that its subviews still can. There is no way to enforce the proper behavior of a PassthroughVisualOutlet, so this protocol serves just as an honor system label which indicates to the client that the conforming entity claims to behave this way.
public protocol PassthroughVisualOutlet: VisualOutlet { }
