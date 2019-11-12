//
//  Shootable.swift
//  Game
//
//  Created by Daniel Slupskiy on 15.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit

protocol Shootable {
    
    
    // MARK: Properties
    
    var damage: CGFloat { get }

    
    // MARK: Lifecycle
    
    func beginFlyingAnimation()
}
