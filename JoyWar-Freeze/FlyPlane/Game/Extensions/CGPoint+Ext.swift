//
//  CGPoint+Ext.swift
//  Game
//
//  Created by Developer on 25.04.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation
import SpriteKit

extension CGPoint {
    
    func distance(toPoint point: CGPoint) -> CGFloat {
        return CGFloat(hypotf(Float(point.x - self.x), Float(point.y - self.y)))
    }
}
